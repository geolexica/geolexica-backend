# (c) Copyright 2020 Ribose Inc.
#

require "open3"
require "singleton"

module Jekyll
  module Geolexica
    module Math

      # A helper class which contains mathematical formulae converter logic.
      class Converter
        include Singleton

        def convert(expression, from:, to:)
          public_send("#{from}_to_#{to}", expression)
        end
      end

      module_function

      # Converts mathematical formula from one notation to another.
      #
      # @param expression [String] expression to be converted
      # @param from [Symbol] input format
      # @param to [Symbol] output format
      #
      # @return [String] converted expression
      def convert(expression, from:, to:)
        Converter.instance.convert(expression, from: from, to: to)
      end
    end
  end
end
