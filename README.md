## Installation

Follow these steps to install and run the application:

1. Clone this repository:

```bash
git clone https://github.com/username/store.git
cd store
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run code generation for models and freezed:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Running the Application

### Debug Mode

To run the application in debug mode:

```bash
flutter run
```

### Release Mode

To build a release version:

#### Android

```bash
flutter build apk --release
```

The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`

#### iOS

```bash
flutter build ios --release
```

Then open the Xcode project and archive the application for distribution.

## Testing

This application has unit tests and widget tests. To run all tests:

```bash
flutter test
```

To run a specific test:

```bash
flutter test test/bloc/products_cubit_test.dart
```

### Test Structure

- `test/bloc/` - Tests for BLoC/Cubit
- `test/usecases/` - Tests for use cases

## Architecture

This application uses Clean Architecture with the following layers:

- **Data Layer**: Repositories, Data Sources, Models
- **Domain Layer**: Entities, Use Cases, Repository Interfaces
- **Presentation Layer**: UI, BLoC/Cubit

## Technologies Used

- **State Management**: Flutter BLoC/Cubit
- **Dependency Injection**: GetIt
- **API Client**: Dio
- **Local Storage**: SharedPreferences
- **Code Generation**: Freezed, JSON Serializable
