https://github.com/user-attachments/assets/97d8eaf2-62da-45b4-b2b3-6355b48212fb

 Categories Feature

This module manages categories in the admin app, including listing, creating, updating, deleting, and browsing products by category.

## Overview

The categories feature follows a clean architecture structure:

- Data layer: remote data source, DTOs, and repository implementation
- Domain layer: entities, repository contract, and use cases
- Presentation layer: screen, BLoC, events, states, and UI widgets

## Folder Structure

- data/
  - datasources/: category remote data source interfaces and implementations
  - models/: category DTOs
  - repository/: repository implementation
- domain/
  - entites/: category entity
  - repositories/: repository contract
  - usecases/: add, get, update, delete, and products-by-category use cases
- presentation/
  - view/: categories screen UI
  - view_model/: BLoC, events, and states
  - widgets/: reusable category UI components

## Main Capabilities

- Display a list of categories
- Add a new category
- Update an existing category
- Delete a category
- View products related to a selected category

## Main Flow

1. The categories screen requests data through the BLoC.
2. The BLoC triggers the appropriate use case.
3. The repository communicates with the remote data source.
4. The UI updates based on success or failure states.

## Key Classes

- CategoriesScreen: main UI for managing categories
- CategoriesBloc: handles category-related state and actions
- GetCategoriesUseCase: fetches categories
- AddCategoryUseCase: creates a new category
- UpdateCategoryUseCase: updates a category
- DeleteCategoryUseCase: removes a category
- GetProductsByCategoryUseCase: retrieves products linked to a category

## Notes

- State management is handled with Flutter BLoC.
- Dependency injection is used through Injectable.
- The feature is designed to work as part of the larger admin dashboard.
