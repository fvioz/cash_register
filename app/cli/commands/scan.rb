# frozen_string_literal: true
# typed: false

module Cli
  module Commands
    class Scan
      extend T::Sig

      sig { params(basket_items: T::Array[String], pricing_rules: Discounts::PricingRulesService, currency: String).void }
      def initialize(basket_items, pricing_rules = Discounts::PricingRulesService.new, currency = 'EUR')
        @basket_items = basket_items
        @currency = currency
        @checkout = Checkouts::CheckoutService.new(pricing_rules)
      end

      sig { void }
      def call
        @basket_items.each do |item|
          @checkout.scan(item.strip)
        rescue StandardError
          puts "Product with code #{item.strip} not found."
        end

        print_receipt
      end

      sig { void }
      def print_receipt
        frame 'Checkout' do
          @checkout.cart.each do |item|
            prrint_item_total(item)
          end

          CLI::UI::Frame.divider('')
          subtotal

          CLI::UI::Frame.divider('{{v}}')
          total
        end
      end

      sig { params(item: Checkouts::CheckoutItemService).void }
      def prrint_item_total(item)
        item_original_total = format_price(item.original_total_price)
        item_total = format_price(item.total_price)

        original_total_string = item_total == item_original_total ? '' : "{{strikethrough:#{item_original_total}}} "

        puts CLI::UI.fmt "#{item.product.name} (x#{item.quantity}): #{original_total_string}#{item_total}"
      end

      sig { void }
      def subtotal
        puts CLI::UI.fmt "Total without discount: {{blue:#{format_price(@checkout.original_total)}}}"
        puts CLI::UI.fmt "Total discount: {{blue:#{format_price(@checkout.discount)}}}"
      end

      sig { void }
      def total
        puts CLI::UI.fmt "{{bold:Total price:}} {{green:#{format_price(@checkout.total)}}}"
      end

      sig { params(name: String, block: T.proc.void).void }
      def frame(name, &block)
        CLI::UI::StdoutRouter.enable
        CLI::UI::Frame.open(name, &block)
      end

      sig { params(amount: BigDecimal).returns(String) }
      def format_price(amount)
        Money.from_amount(amount, @currency).format
      end
    end
  end
end
