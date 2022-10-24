set -e
flutter clean
flutter pub get
flutter pub run build_runner watch --delete-conflicting-outputs
flutter pub run build_runner build --enable-experiment=enhanced-enums --delete-conflicting-outputs

flutter gen-l10n

SHA1: E4:19:54:96:E7:FC:31:B9:10:B9:67:B0:62:52:BB:9F:C6:7F:AA:68
SHA256: 55:3A:D0:B2:F9:BA:F6:F1:97:49:CF:81:57:0D:3F:95:AB:A0:12:BE:13:94:66:88:DF:74:53:8A:78:8B:E1:31