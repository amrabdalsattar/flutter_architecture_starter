#!/usr/bin/env python3
"""
Flutter Easy Localization Sync Script
======================================
Synchronizes JSON localization files with Dart localization classes.
Deletes and fully regenerates the topics directory on every run.

Usage:
    python generate_locale_keys.py
"""

import json
import re
import shutil
from pathlib import Path


# ─────────────────────────────────────────────
# CONFIG (edit these paths directly)
# ─────────────────────────────────────────────
JSON_DIR = Path("../assets/translations")
DART_DIR = Path("../lib/core/helpers/localization/topics")
AR_FILE = "ar.json"
EN_FILE = "en.json"


# ─────────────────────────────────────────────
# NAMING HELPERS
# ─────────────────────────────────────────────

def camel_to_snake(name: str) -> str:
    s = re.sub(r"([A-Z]+)([A-Z][a-z])", r"\1_\2", name)
    s = re.sub(r"([a-z\d])([A-Z])", r"\1_\2", s)
    return s.lower()


def key_to_dart_filename(top_key: str) -> str:
    return f"{camel_to_snake(top_key)}_locale.dart"


def key_to_dart_classname(top_key: str) -> str:
    pascal = "".join(word.capitalize() for word in camel_to_snake(top_key).split("_"))
    return f"_{pascal}Locale"


def extract_placeholders(value: str) -> list[str]:
    """Extract {placeholder} names from a translation string."""
    return re.findall(r"\{(\w+)\}", value)


# ─────────────────────────────────────────────
# DART CODE GENERATION
# ─────────────────────────────────────────────

def generate_dart_method(top_key: str, sub_key: str, en_value: str) -> str:
    """
    Generate a Dart getter or function for a translation key.

    Simple key   → String get noComments => "community.noComments".tr();
    With params  → String errorAddingComment(String error) => ...
    """
    full_key = f"{top_key}.{sub_key}"
    placeholders = extract_placeholders(en_value)

    if not placeholders:
        return f"  String get {sub_key} => '{full_key}'.tr();"
    else:
        params = ", ".join(f"String {p}" for p in placeholders)
        named_args = ", ".join(f"'{p}': {p}" for p in placeholders)
        return (
            f"  String {sub_key}({params}) =>\n"
            f"      '{full_key}'.tr(\n"
            f"          namedArgs: {{{named_args}}});"
        )


# ─────────────────────────────────────────────
# VALIDATION
# ─────────────────────────────────────────────

class ValidationError(Exception):
    pass


def validate_key_consistency(
    top_key: str,
    sub_key: str,
    ar_value: str,
    en_value: str,
) -> None:
    """Ensure placeholder variables match between ar and en."""
    ar_placeholders = set(extract_placeholders(ar_value))
    en_placeholders = set(extract_placeholders(en_value))

    if ar_placeholders != en_placeholders:
        raise ValidationError(
            f"Placeholder mismatch for '{top_key}.{sub_key}':\n"
            f"  en: {sorted(en_placeholders)}\n"
            f"  ar: {sorted(ar_placeholders)}"
        )


# ─────────────────────────────────────────────
# FILE READ / WRITE
# ─────────────────────────────────────────────

def load_json(path: Path) -> dict:
    try:
        with path.open(encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        raise SystemExit(f"  ✗ File not found: {path}")
    except json.JSONDecodeError as e:
        raise SystemExit(f"  ✗ Invalid JSON in {path}: {e}")


def scaffold_dart_file(top_key: str) -> str:
    """Scaffold a fresh Dart file for the given top-level key."""
    class_name = key_to_dart_classname(top_key)
    return (
        "part of '../locale_keys.dart';\n"
        "\n"
        f"class {class_name} {{\n"
        f"  const {class_name}();\n"
        "}\n"
    )


def insert_method_into_class(
    content: str,
    class_name: str,
    dart_method: str,
) -> str:
    """Insert dart_method before the closing `}` of the named class."""
    class_pattern = re.compile(
        rf"(class\s+{re.escape(class_name)}\s*\{{.*?)(^\}})",
        re.DOTALL | re.MULTILINE,
    )
    match = class_pattern.search(content)
    if not match:
        raise ValidationError(
            f"Could not locate class '{class_name}' in Dart file."
        )

    class_body = match.group(1)
    closing_brace = match.group(2)

    separator = "\n" if class_body.rstrip().endswith(");") or class_body.rstrip().endswith("//") else "\n"
    insertion = f"{separator}{dart_method}\n"

    new_class_body = class_body.rstrip("\n") + "\n" + insertion
    new_content = content[: match.start()] + new_class_body + closing_brace + content[match.end():]
    return new_content


# ─────────────────────────────────────────────
# CORE SYNC LOGIC
# ─────────────────────────────────────────────

def sync_localization() -> None:
    ar_data = load_json(JSON_DIR / AR_FILE)
    en_data = load_json(JSON_DIR / EN_FILE)

    if DART_DIR.exists():
        shutil.rmtree(DART_DIR)
    DART_DIR.mkdir(parents=True)

    all_top_keys = set(ar_data.keys()) | set(en_data.keys())
    errors: list[str] = []
    total_inserted = 0
    total_skipped = 0

    for top_key in sorted(all_top_keys):
        ar_section: dict = ar_data.get(top_key, {})
        en_section: dict = en_data.get(top_key, {})

        dart_filename = key_to_dart_filename(top_key)
        class_name = key_to_dart_classname(top_key)
        dart_path = DART_DIR / dart_filename

        common_keys = set(ar_section.keys()) & set(en_section.keys())
        only_in_ar = set(ar_section.keys()) - set(en_section.keys())
        only_in_en = set(en_section.keys()) - set(ar_section.keys())

        for k in sorted(only_in_ar):
            errors.append(f"'{top_key}.{k}' exists only in ar.json — skipping")
            total_skipped += 1

        for k in sorted(only_in_en):
            errors.append(f"'{top_key}.{k}' exists only in en.json — skipping")
            total_skipped += 1

        if not common_keys:
            continue

        dart_content = scaffold_dart_file(top_key)

        for sub_key in sorted(common_keys):
            ar_value = ar_section[sub_key]
            en_value = en_section[sub_key]

            try:
                validate_key_consistency(top_key, sub_key, ar_value, en_value)
            except ValidationError as e:
                errors.append(str(e))
                total_skipped += 1
                continue

            dart_method = generate_dart_method(top_key, sub_key, en_value)

            try:
                dart_content = insert_method_into_class(
                    dart_content, class_name, dart_method
                )
                total_inserted += 1
            except ValidationError as e:
                errors.append(str(e))
                total_skipped += 1

        dart_path.write_text(dart_content, encoding="utf-8")

    print(f"\nInserted : {total_inserted} method(s)")
    print(f"Skipped  : {total_skipped} key(s)")
    if errors:
        print(f"\nErrors ({len(errors)}):")
        for e in errors:
            print(f"  • {e}")


# ─────────────────────────────────────────────
# ENTRY POINT
# ─────────────────────────────────────────────

if __name__ == "__main__":
    sync_localization()