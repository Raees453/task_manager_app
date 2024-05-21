
## Task Manager App - A Flutter Project

This README.md file is written in Markdown format for easy copy-paste.

## Project Overview

This is a well-structured Flutter application that implements user authentication, task management,  state management with Provider, dependency injection with GetIt, MVVM architecture, local storage using Shared Preferences, and **navigation with go_router**. It prioritizes a simple and user-friendly UI while offering robust functionality.

## Features

-   **User Authentication:** Secure login using credentials from [https://dummyjson.com/docs/auth](https://dummyjson.com/docs/auth)
-   **Task Management:**
  -   View, Add, Edit, and Delete tasks
  -   Persist tasks locally using Shared Preferences
-   **State Management:** Leverage Provider for efficient state management across the app
-   **Dependency Injection:** Simplified dependency management with GetIt
-   **MVVM Architecture:** Organized code structure with clear separation of concerns
-   **Navigation:** Utilize go_router for smooth and efficient navigation between screens
-   **Simple and Sleek UI:** User-friendly interface designed for clarity and ease of use

## Getting Started

### Prerequisites

-   Flutter development environment set up ([https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install))
-   Basic understanding of Flutter, Dart, and MVVM architecture

### Installation

1.  Clone this repository.
2.  Run `flutter pub get` to install dependencies.

### Configuration

-   Replace placeholders in `lib/services/api_service.dart` with your preferred dummyjson API credentials (if applicable).
-   (Optional) Customize UI elements and functionalities as needed.

### Run the App

-   Run `flutter run` to launch the app on your device or emulator.

## Technologies

-   Flutter (mobile development framework)
-   Provider (state management)
-   GetIt (dependency injection)
-   Shared Preferences (local storage)
-   go_router (navigation)
