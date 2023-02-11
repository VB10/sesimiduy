#rm -rf ~/Library/Developer/Xcode/DerivedData/*
#rm -rf ~/Library/Caches/CocoaPods
flutter clean
rm pubspec.lock
cd ios
rm -rf Pods
rm Podfile.lock
pod deintegrate
flutter pub get
pod setup
pod install
cd ..
#flutter build ios
#flutter build appbundle
