# Architecture Overview

The Cash Register application is designed with a modular architecture to ensure scalability, maintainability, and ease of testing. Below is an overview of the domain, the main components and their interactions.

## Domains

The application is divided into several domains, each responsible for a specific aspect of the cash register functionality:

- **Products**: Manages product information, including product codes, names, and prices.
- **Checkouts**: Handles the checkout process, including scanning items and calculating totals.
- **Discounts**: Implements various discount rules and pricing strategies.

Each domain is encapsulated within its own directory under the `components` folder, promoting separation of concerns and modularity.

Domain interactions are described in the section `dependencies:` inside the file `package.yml` of each components.

## Components

For a detailed overview of each component, refer to the README.md file of each component under the `components` folder.

## Applications

### CLI Application

The CLI application provides a command-line interface for users to interact with the cash register system. It allows users to scan items and view the discounts and the total price.
