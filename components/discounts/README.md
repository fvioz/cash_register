Welcome to `components/discounts`!

This directory contains components related to discounts in the cash register system. Below is an overview of the files and their purposes:

- Services:
  - `no_discount_service.rb`: This file defines the `NoDiscountService`, which implements a strategy for handling scenarios where no discount is applied to a product.
  - `free_item_discount_service.rb`: This file defines the `FreeItemDiscountService`, which implements a strategy for applying a "buy one, get one free" discount to products.
  - `percentage_discount_service.rb`: This file defines the `PercentageDiscountService`, which implements a strategy for applying a percentage-based discount to products.
  - `bulk_discount_service.rb`: This file defines the `BulkDiscountService`, which implements a strategy for applying discounts based on the quantity of products purchased.
