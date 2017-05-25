require_relative "../base_service"
module Services
  module Converters
    class ToAndFromRomanNumerals < BaseService
      attr_accessor :array_of_numbers

      ROMAN_MAPPING =
        {
          1000 => "M",
          900 => "CM",
          500 => "D",
          400 => "CD",
          100 => "C",
          90 => "XC",
          50 => "L",
          40 => "XL",
          10 => "X",
          9 => "IX",
          5 => "V",
          4 => "IV",
          1 => "I"
        }

      def initialize(array_of_number_to_convert)
        @array_of_numbers = array_of_number_to_convert
        @performed = false
        @errors = []
        @results = []
      end

      def allow?
        return true if @array_of_numbers.kind_of?(Array) && @array_of_numbers.any?
      end

      def perform_if_allowed
        @array_of_numbers.each do |number|
          if is_arabic?(number)
            @results << to_roman(number)
          elsif is_roman?(number)
            @results << to_arabic(number)
          else
            @errors << number
          end
        end
      end

      private

      def is_roman?(number)
        #regex taken from http://rubular.com/r/KLPR1zq3Hj  - https://stackoverflow.com/questions/267399/how-do-you-match-only-valid-roman-numerals-with-a-regular-expression
        number =~ /(^(?=[MDCLXVI])M*(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$)/
      end

      def is_arabic?(number)
        !!Float(number) rescue nil
      end

      def to_roman(number)
        roman = ""
        ROMAN_MAPPING.each do |value, letter|
          roman << letter*(number / value)
          number = number % value
        end
        roman
      end

      def to_arabic(number)
        result = 0
        ROMAN_MAPPING.values.each do |roman|
          while number.start_with?(roman)
            result += ROMAN_MAPPING.invert[roman]
            number = number.slice(roman.length, number.length)
          end
        end
        result
      end

    end #END class
  end
end #END module
