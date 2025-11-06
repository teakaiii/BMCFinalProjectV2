# Project Blueprint: Charlotte Folk Mobile App

## Overview

This document outlines the design, features, and development plan for the Charlotte Folk mobile application. The goal is to create a beautiful, functional, and user-friendly e-commerce experience based on the brand's existing web presence.

## Current State & Implemented Features (Modules 1-8)

The application currently incorporates the following features:

*   **User Authentication:**
    *   Email/Password sign-up and login.
    *   Persistent login state.
    *   Role-based access control (`user` vs. `admin`).

*   **Product Management (Admin):**
    *   An admin panel for creating, updating, and deleting products.
    *   Products include name, description, price, and an image URL.

*   **Product Catalog (User):**
    *   A home screen that displays all products in a grid view.
    *   A product detail screen to view more information about a specific product.

*   **Shopping Cart:**
    *   Users can add and remove products from their shopping cart.
    *   The cart icon in the app bar updates with a badge showing the number of items.
    *   A dedicated cart screen shows all items, quantities, and the total price.

*   **Theming & Styling:**
    *   Basic light/dark mode support.
    *   Initial Material Design 3 theme.

## Current Task: UI Upgrade to `charlottefolk.co` Style

This section outlines the plan to elevate the app's user interface to match the sophisticated and minimalist aesthetic of the [charlottefolk.co](https://charlottefolk.co/) website.

### 1. Analyze Visual Identity

*   **Color Palette:** Minimalist and high-contrast.
    *   **Primary Background:** White (`#FFFFFF`)
    *   **Primary Text/Elements:** Black (`#000000`)
    *   **Accent/Call-to-Action:** Vibrant Blue (e.g., `#4A90E2`)
*   **Typography:** A dual-font system for elegance and readability.
    *   **Headings/Titles:** A classic Serif font (e.g., `Playfair Display`).
    *   **Body/UI Text:** A clean Sans-Serif font (e.g., `Lato`).
*   **Layout & Components:** Clean, spacious, and minimalist.
    *   Emphasis on product imagery.
    *   Generous use of white space.
    *   Simple, clear user interface components.

### 2. Implementation Plan

*   **Phase 1: Foundational Theming (In Progress)**
    *   **Action:** Update `lib/main.dart`.
    *   **Details:**
        *   Replace the existing `ColorScheme` with the new black, white, and blue palette.
        *   Define a new `TextTheme` using `google_fonts` to import and apply `Playfair Display` and `Lato`.
        *   Update default styles for `AppBar`, `ElevatedButton`, and `Card` to reflect the new design.

*   **Phase 2: Component Redesign**
    *   **Action:** Refactor `lib/widgets/product_card.dart`.
    *   **Details:** Change the layout from a text overlay to a clean card with the image at the top and the product name and price displayed neatly below, center-aligned.

*   **Phase 3: Screen-by-Screen Refresh**
    *   **Action:** Update all `lib/screens/*.dart` files.
    *   **Details:** Adjust the layout and spacing of each screen to align with the new minimalist aesthetic, ensuring a consistent and polished user experience.

