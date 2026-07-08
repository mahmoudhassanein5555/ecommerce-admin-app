# Ecommerce Admin App

A modern Flutter-based admin application for managing an e-commerce platform with a clean, scalable, and maintainable architecture. This project is currently under active development and is being expanded module by module.

![Status](https://img.shields.io/badge/Status-Under%20Active%20Development-yellow)

## Project Status

This project is currently in active development. Core architecture and foundational features are being implemented progressively, with some modules already available and others being expanded.

## Tech Stack

- Flutter
- Dart
- BLoC / Cubit for state management
- Clean Architecture principles
- REST API integration
- Material Design UI

## Features Implemented

- [x] Authentication Module
  - Login flow
  - UI and state handling
  - Basic authentication integration
- [x] Product Management
  - Core product features implemented
  - Product listing and related flows are ready
- [x] Category Management
  - Category management flow implemented
  - Category-related UI and logic are in place
- [ ] Dashboard Overview
  - Coming Soon
- [ ] Orders & Sales Management
  - Coming Soon
  - Planned
- [x] Orders & Sales Management
  - **Real-time Order Tracking**: Utilizes Firebase Firestore streams to display incoming orders in real-time.
  - **Split-Screen UI**: A responsive master-detail layout allows for efficient browsing. Admins can view a list of recent orders and see detailed information for a selected order simultaneously.
  - **Comprehensive Order Details**: The detail panel provides a complete overview, including order items, customer information (name, contact, shipping address), and a full payment summary (subtotal, shipping, tax, and total).
  - **Order Status Management**: Admins can update the status of an order (e.g., 'Processing', 'Shipped', 'Delivered'), with changes reflected instantly in the database.
  - **PDF Invoice Generation**: A feature to generate and download a professional PDF invoice for any order, complete with company branding, customer details, and an itemized breakdown.
- [ ] Chat Support
  - Planned after Orders
  - Planned
- [ ] User & Role Management
  - Coming Soon
  - Planned

## Getting Started

### Prerequisites

Make sure you have Flutter installed on your machine.

### Clone the repository

```bash
git clone https://github.com/mahmoudhassanein5555/ecommerce-admin-app.git
cd ecommerce_admin_app
```

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

## Project Structure

The project is organized using Clean Architecture to separate concerns between:

- Presentation layer
- Domain layer
- Data layer

This structure helps improve testability, maintainability, and future scalability.

## Contribution

Contributions are welcome as the project continues to grow. Feel free to open issues, suggest improvements, or contribute new features.

## License

This project is currently under development and the license may be updated as the project matures.
