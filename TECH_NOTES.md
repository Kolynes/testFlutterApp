# Architecture & Key Trade-offs

## Architecture Overview
This Flutter app uses a layered architecture:
- **Data Layer:** Handles network requests (Dio with retry interceptor) and local storage (Hive).
- **Repository Layer:** Abstracts data sources and provides streams for business logic.
- **ViewModel Layer:** Manages state and commands, exposing data and actions to the UI using Provider and Command pattern.
- **Presentation Layer:** Flutter widgets consume ViewModel state, using ValueListenableBuilder and Selector for reactivity. Navigation is managed via named routes.

## Key Trade-offs
- **Simplicity vs. Flexibility:** The app uses a simple ViewModel and Command pattern for state management, which is easy to follow but less flexible than more advanced solutions (e.g., Riverpod, Bloc).
- **Error Handling:** Errors are surfaced via ValueListenables and snackbars, which is user-friendly but could be more robust with custom error widgets or dialogs.
- **Generic UI Components:** The BusinessCard widget is made generic for code reuse, but type checks are used instead of a formal interface/abstraction.
- **Retry Logic:** Retry state is not deeply integrated into the ViewModel/UI, but could be exposed for better user feedback.

## Improvements with More Time
- Introduce a shared interface or sealed class for DTOs to improve type safety in generic widgets.
- Add more comprehensive tests (unit, widget, integration).
- Enhance error and loading states with custom widgets and animations.
- Integrate retry state into the ViewModel for better UI feedback on network retries.
- Use a more scalable state management solution for larger apps (e.g., Riverpod, Bloc).
- Improve accessibility and theming.
