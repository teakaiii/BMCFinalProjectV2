# Project Blueprint: eCommerce App

## Overview

This document outlines the features, design, and architecture of a modern eCommerce application built with Flutter and Firebase. The goal is to create a beautiful, responsive, and feature-rich app.

## Design Inspiration

*   **Website:** [charlottefolk.co](https://charlottefolk.co/)
*   **Aesthetic:** Clean, modern, minimalist, with a strong focus on typography and bold colors.
*   **Logo:** The "CHARLOTTE FOLK STUDIOS" logo is used for the splash screen and app icon.

## Implemented Features (Current State)

*   **Project Setup (Module 1):**
    *   Flutter project created and Firebase configured.

*   **Branding & Splash Screen (Module 2):**
    *   `flutter_native_splash` configured and generated.

*   **Theming (Module 3):**
    *   A full Material 3 theme system with `google_fonts` and `provider` for light/dark mode toggle.

## Plan for Current Request (Authentication UI)

1.  **Create File Structure:**
    *   Create the `lib/screens` directory.
    *   Create `login_screen.dart` and `signup_screen.dart`.
2.  **Build Login Screen:**
    *   Implement the `LoginScreen` as a `StatefulWidget`.
    *   Add a form with email and password fields, including validation.
    *   Add a login button and a text button to navigate to the sign-up screen.
3.  **Build Sign Up Screen:**
    *   Create the `SignUpScreen` based on the login screen.
    *   Adjust titles and button text.
    *   Implement navigation back to the login screen.
4.  **Update `main.dart`:**
    *   Set `LoginScreen` as the initial route for the app.
