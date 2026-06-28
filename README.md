Products Feature


https://github.com/user-attachments/assets/ec1cdcbd-255c-4fc0-bcd5-dd977a705f7d


This feature provides full product management for the Ecommerce Admin App. It allows admins to view, add, update, delete, and upload images for products through a clean and structured Flutter architecture.

## Overview

The Products feature is built using Clean Architecture and the BLoC pattern. It is designed to separate UI, business logic, and data handling for easier maintenance and scalability.

## Features

- View all products
- Add a new product
- Update an existing product
- Delete a product
- Upload product images
- Handle loading, success, and error states
- Keep the UI responsive and easy to use

## Project Structure

```text
lib/features/products/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repository/
├── domain/
│   ├── entites/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── view/
    ├── view_model/
    └── widgets/
```

## Architecture

This feature follows a layered structure:

- Presentation Layer: UI and BLoC state management
- Domain Layer: business rules and use cases
- Data Layer: repository implementation and remote data source

## Main Components

- ProductsScreen: main screen for product management
- ProductsBloc: handles product events and states
- ProductCard: reusable widget for displaying a product
- ProductImagePickerWidget: widget for choosing product images
- ProductProperties: form UI for product details

## Tech Stack

- Flutter
- BLoC
- Dio
- GetIt / Injectable
- Dartz
- File Picker

## Setup

1. Install dependencies:

```bash
flutter pub get
```

2. Generate dependency injection files if needed:

```bash
dart run build_runner build
```

3. Run the app:

```bash
flutter run
```

## Usage

The feature is integrated into the admin dashboard and can be used to manage products directly from the admin interface.

## Notes

- The feature is designed to work with the backend API configured in the app.
- Error handling and loading states are already included to improve the user experience.

## Contributing

If you want to extend this feature, follow the existing Clean Architecture structure and keep the UI and logic clearly separated.
