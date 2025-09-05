# frozen_string_literal: true
# typed: true

require 'money'

Money.locale_backend = :i18n
Money.rounding_mode = BigDecimal::ROUND_HALF_UP
