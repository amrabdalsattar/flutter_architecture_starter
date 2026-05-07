import json
import re
import os
import difflib

def flatten_dict(d, parent_key='', sep='.'):
    items = []
    for k, v in d.items():
        new_key = f"{parent_key}{sep}{k}" if parent_key else k
        if isinstance(v, dict):
            items.extend(flatten_dict(v, new_key, sep=sep).items())
        else:
            items.append((new_key, str(v)))
    return dict(items)

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    ar_path = os.path.join(script_dir, r'../assets/translations/ar.json')
    en_path = os.path.join(script_dir, r'../assets/translations/en.json')
    dart_dir = os.path.join(script_dir, r'../lib/core/helpers/localization/topics')
    
    with open(ar_path, 'r', encoding='utf-8') as f:
        ar_keys = set(flatten_dict(json.load(f)).keys())
        
    with open(en_path, 'r', encoding='utf-8') as f:
        en_keys = set(flatten_dict(json.load(f)).keys())
        
    dart_keys = set()
    pattern = r'["\']([^"\']+)["\']\.tr\('
    
    for root, dirs, files in os.walk(dart_dir):
        for file in files:
            if file.endswith('.dart'):
                with open(os.path.join(root, file), 'r', encoding='utf-8') as f:
                    content = f.read()
                    matches = re.findall(pattern, content)
                    for m in matches:
                        dart_keys.add(m)
    
    out_lines = []
    out_lines.append("--- Analysis Report ---")
    
    out_lines.append("\n1. Missing keys per file:")
    out_lines.append("Keys in ar.json but missing in en.json:")
    diff_ar_en = sorted(ar_keys - en_keys)
    if diff_ar_en:
        for k in diff_ar_en:
            out_lines.append(f"  - {k}")
    else:
        out_lines.append("  [None]")
        
    out_lines.append("\nKeys in en.json but missing in ar.json:")
    diff_en_ar = sorted(en_keys - ar_keys)
    if diff_en_ar:
        for k in diff_en_ar:
            out_lines.append(f"  - {k}")
    else:
        out_lines.append("  [None]")
        
    out_lines.append("\n2. Keys in JSON files that are not present in locale keys classes (Extra keys):")
    all_json_keys = ar_keys | en_keys
    extra_keys = sorted(all_json_keys - dart_keys)
    if extra_keys:
        for k in extra_keys:
            out_lines.append(f"  - {k}")
    else:
        out_lines.append("  [None]")
        
    out_lines.append("\n3. Missing keys in JSON files (Used in Dart but missing in JSON files):")
    out_lines.append("Missing in ar.json:")
    missing_ar = sorted(dart_keys - ar_keys)
    if missing_ar:
        for k in missing_ar:
            out_lines.append(f"  - {k}")
    else:
        out_lines.append("  [None]")
        
    out_lines.append("\nMissing in en.json:")
    missing_en = sorted(dart_keys - en_keys)
    if missing_en:
        for k in missing_en:
            out_lines.append(f"  - {k}")
    else:
        out_lines.append("  [None]")
        
    out_lines.append("\n4. Possible misspellings (similar keys between JSON/Dart):")
    missing_in_json = dart_keys - all_json_keys
    found_misspellings = False
    for mk in sorted(missing_in_json):
        matches = difflib.get_close_matches(mk, all_json_keys, n=3, cutoff=0.7)
        if matches:
            found_misspellings = True
            out_lines.append(f"  - '{mk}' used in Dart might be misspelled. Did you mean: {', '.join(matches)}?")
    if not found_misspellings:
        out_lines.append("  [None]")
        
    with open('report.txt', 'w', encoding='utf-8') as f:
        f.write('\n'.join(out_lines))

if __name__ == '__main__':
    main()
