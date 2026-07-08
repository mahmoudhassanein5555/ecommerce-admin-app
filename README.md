# Orders & Sales Management Module

https://github.com/user-attachments/assets/dc48977e-4102-4b9a-a5fd-a67b7672d44d

This module is responsible for handling all aspects of order and sales management within the e-commerce admin panel. It provides administrators with a comprehensive interface to monitor, process, and analyze sales transactions in real-time.

## Key Features

The Orders module is designed with a focus on efficiency and clarity, providing the following key features:

- **Real-time Order Feed**: Utilizes a stream-based connection to Firebase Firestore to display new orders instantly as they are placed by customers. This ensures the admin dashboard is always up-to-date without requiring manual refreshes.

- **Responsive Master-Detail UI**: The user interface is built with a responsive, two-panel layout.
  - **Master Panel**: Displays a paginated list of recent orders with key information like Order ID, customer name, total amount, and status.
  - **Detail Panel**: Shows comprehensive details for a selected order, including an itemized list, payment summary, and customer information. An instructional placeholder is shown if no order is selected.

- **Comprehensive Order Details**: When an order is selected, the detail panel provides a full breakdown:
  - **Order Items**: A list of all products in the order, including their quantity and individual prices.
  - **Payment Summary**: A clear summary of the subtotal, shipping fees, taxes, and the final total amount. It also includes the payment method and transaction ID.
  - **Customer Information**: Displays the customer's profile name and the shipping address for the order.

- **Order Status Management**: Administrators can update the status of an order (e.g., from 'Processing' to 'Shipped'). The change is immediately persisted to the database and reflected in the UI.

- **Data Export**: Includes functionality to export order data into a CSV file, allowing for offline analysis and record-keeping.

- **Receipt Printing**: A feature to generate and print a detailed receipt or invoice for any given order.

## Technical Implementation

This module adheres to the principles of **Clean Architecture**, separating concerns into three distinct layers:

### 1. Data Layer
- **`data/data_source/`**: Contains `OrdersDataSource`, which is responsible for direct communication with the backend (Firebase Firestore). It handles the logic for fetching and streaming order data.
- **`data/repository/`**: The `OrderRepoImp` implements the `OrdersRepo` interface from the domain layer. It bridges the data source with the domain layer, handling data conversion (from DTOs to Entities) and managing error handling and stream transformations.

### 2. Domain Layer
- **`domain/entity/`**: Defines the core `OrderEntity` object, which represents a clean, implementation-free model of an order.
- **`domain/repository/`**: Contains the abstract `OrdersRepo` contract, defining the methods that the domain layer expects the data layer to implement (e.g., `getOrders()`).
- **`domain/use_cases/`**: (If applicable) Holds the business logic for specific actions, such as `GetOrdersUseCase`, which would be invoked by the presentation layer.

### 3. Presentation Layer
- **State Management**: BLoC/Cubit is used to manage the state of the orders feature. The `OrdersCubit` or `OrdersBloc` fetches data via the use cases/repository and exposes states like `Loading`, `Success`, and `Error` to the UI.
- **`presentation/screens/`**: Contains the main `OrdersScreen` widget that assembles the different UI components.
- **`presentation/widgets/`**: A collection of reusable widgets that make up the Orders screen, such as:
  - `OrdersListPanel`: The master view showing the list of recent orders.
  - `OrderDetailPanel`: The detail view for a single order.
  - `OrdersListHeader`: The header for the orders table.
  - `NoOrderSelectedWidget`: The placeholder shown in the detail panel.

## Module Structure

```
lib/
└── features/
    └── orders/
        ├── data/
        │   ├── data_source/
        │   │   └── orders_data_source.dart
        │   └── repository/
        │       └── order_repo_imp.dart
        ├── domain/
        │   ├── entity/
        │   │   └── order_entity.dart
        │   └── repository/
        │       └── orders_repo.dart
        └── presentation/
            ├── bloc/
            └── widgets/
```

This file provides a comprehensive guide to the Orders feature, making it much easier for anyone working on the project to get up to speed.

<!--
[PROMPT_SUGGESTION]Generate the BLoC/Cubit files for the Orders feature based on this README.[/PROMPT_SUGGESTION]
[PROMPT_SUGGESTION]Create the UI widgets described in the `presentation/widgets` section of this new README.[/PROMPT_SUGGESTION]
