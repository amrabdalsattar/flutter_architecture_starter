# Python Scripts for Localization (l10n)

This directory contains Python scripts to assist with Flutter localization management. These scripts help synchronize translation files with Dart code and analyze localization consistency.

## Scripts Overview

### 1. `generate_locale_keys.py`

**Purpose**: Automatically generates Dart localization classes from JSON translation files.

**What it does**:
- Reads `ar.json` and `en.json` from `../assets/translations/`
- Generates Dart classes in `../lib/core/helpers/localization/topics/`
- Creates getter methods for simple translations and parameterized methods for translations with placeholders
- Validates placeholder consistency between Arabic and English translations
- Fully regenerates the topics directory on each run

**Usage**:
```bash
python generate_locale_keys.py
```

**Prerequisites**:
- Python 3.x installed
- Translation files exist at `../assets/translations/ar.json` and `../assets/translations/en.json`
- JSON files must have matching top-level keys for synchronization

**Output**:
- Creates Dart files like `auth_locale.dart`, `common_locale.dart`, etc.
- Each file contains a class with methods corresponding to translation keys
- Prints summary of inserted methods and any errors

**Example Generated Code**:
```dart
class _AuthLocale {
  const _AuthLocale();

  String get login => "auth.login".tr();

  String welcomeMessage(String name) =>
      "auth.welcomeMessage".tr(
          namedArgs: {'name': name});
}
```

### 2. `compare.py`

**Purpose**: Analyzes localization consistency across JSON files and Dart code.

**What it does**:
- Compares keys between `ar.json` and `en.json`
- Scans Dart files in `../lib/core/helpers/localization/topics/` for `.tr()` usage
- Identifies missing keys, extra keys, and potential misspellings
- Generates a detailed analysis report

**Usage**:
```bash
python compare.py
```

**Prerequisites**:
- Python 3.x installed
- Translation files exist at `../assets/translations/ar.json` and `../assets/translations/en.json`
- Dart localization classes exist in `../lib/core/helpers/localization/topics/`

**Output**:
- Creates `report.txt` with detailed analysis
- Reports include:
  1. Missing keys between JSON files
  2. Extra keys not used in Dart code
  3. Keys used in Dart but missing from JSON files
  4. Potential misspellings using fuzzy matching

**Example Report**:
```
--- Analysis Report ---

1. Missing keys per file:
Keys in ar.json but missing in en.json:
  - auth.forgotPassword

Keys in en.json but missing in ar.json:
  [None]

2. Keys in JSON files that are not present in locale keys classes (Extra keys):
  - common.unusedKey

3. Missing keys in JSON files (Used in Dart but missing in JSON files):
Missing in ar.json:
  - auth.newFeature

Missing in en.json:
  [None]

4. Possible misspellings (similar keys between JSON/Dart):
  - 'auth.logi' used in Dart might be misspelled. Did you mean: auth.login?
```

## Workflow

1. **Add new translations**: Update both `ar.json` and `en.json` with new keys
2. **Generate classes**: Run `generate_locale_keys.py` to create/update Dart classes
3. **Check consistency**: Run `compare.py` to verify everything is synchronized
4. **Review report**: Check `report.txt` for any issues or missing translations

## File Structure

```
l10n/
├── compare.py              # Analysis script
├── generate_locale_keys.py # Code generation script
└── report.txt              # Generated analysis report
```

## Dependencies

- Python 3.x
- Standard library modules: `json`, `re`, `os`, `difflib`, `shutil`, `pathlib`

## Notes

- `generate_locale_keys.py` deletes and recreates the entire topics directory
- Both scripts expect UTF-8 encoded JSON files
- Placeholder validation ensures `{variable}` names match between languages
- The scripts are designed for Flutter Easy Localization package usage</content>
<parameter name="filePath">d:\Flutter\flutter_architecture_starter\l10n\l10n_python_scripts.md