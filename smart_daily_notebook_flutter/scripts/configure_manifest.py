import os

manifest_path = os.path.join("android", "app", "src", "main", "AndroidManifest.xml")

if os.path.exists(manifest_path):
    with open(manifest_path, "r", encoding="utf-8") as f:
        content = f.read()

    permissions = [
        '<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>',
        '<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>',
        '<uses-permission android:name="android.permission.VIBRATE"/>',
    ]

    to_add = [p for p in permissions if p not in content]
    if to_add:
        addition = "\n    " + "\n    ".join(to_add)
        content = content.replace("<application", addition + "\n    <application", 1)
        with open(manifest_path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"Added missing permissions: {to_add}")
    else:
        print("All permissions already present.")
else:
    print(f"File {manifest_path} not found.")
