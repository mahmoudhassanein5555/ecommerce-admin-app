https://github.com/user-attachments/assets/c43afed3-ff85-4b66-befe-a8b6982d86d7

# Auth Feature

This module handles authentication for the admin application, including the login screen, state management, and API integration.

## Overview

The auth feature follows a clean architecture approach with three layers:

- Data layer: API communication, DTOs, and repository implementation
- Domain layer: entities, repository contract, and use cases
- Presentation layer: UI screen, BLoC, events, and states

## Folder Structure

- data/
  - datasources/: login data source interfaces and implementations
  - models/: request and response DTOs
  - repository/: repository implementation
- domain/
  - entites/: request and response entities
  - repositories/: repository contract
  - usecases/: login use case
- presentation/
  - view/: login screen UI
  - view_model/: BLoC, events, and states
  - widgets/: reusable UI widgets

## Main Flow

1. The user enters an email and password in the login screen.
2. The login form sends a LoginButtonPressed event to the BLoC.
3. The BLoC calls the LoginUseCase.
4. The repository checks connectivity and sends the login request to the data source.
5. The result is returned as either a success or failure state, and the UI shows a toast message.

## Key Classes

- LoginScreen: the authentication UI
- LoginBloc: manages login state and events
- LoginUseCase: business logic entry point for login
- LoginRepoImp: repository implementation for login
- LoginDataSource: API source for authentication requests

## Notes

- The feature uses Flutter BLoC for state management.
- Dependency injection is handled through Injectable.
- Network and error handling are centralized through the core error and failure layers.
