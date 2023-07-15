.PHONY:
clean:
	flutter clean
	flutter pub get

build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs

buld_web:
	flutter build web --web-renderer html --csp

run_web:
	flutter run -d chrome --web-renderer html --csp

launch_icon:
	flutter pub pub run flutter_launcher_icons:main

json_format:
	file.txt | jq .

analyze:
	dart fix --apply
	flutter analyze

test:
	flutter test

test_coverage:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html

ios_hard_clear:
	flutter clean
	rm -Rf build
	rm -Rf ios/Flutter/Flutter.framework
	rm -Rf ios/Flutter/Flutter.podspec
	rm -Rf ios/Flutter/App.framework
	rm -Rf ios/Pods
	rm -Rf ios/.symlinks
	rm -Rf ios/build
	rm -Rf ios/Runner.xcworkspace
	rm -f ios/Podfile
	rm -f ios/Podfile.lock
	rm -f pubspec.lock
	flutter pub get

flutter_metrics:
	flutter pub run dart_code_metrics:metrics analyze lib