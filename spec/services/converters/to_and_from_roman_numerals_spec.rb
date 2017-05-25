require_relative '../../spec_helper'
require_relative '../../../services/converters/to_and_from_roman_numerals'

describe Services::Converters::ToAndFromRomanNumerals do

  subject { described_class.new(array_of_numbers) }

  context "#perform" do

    before do
      subject.perform
    end

    context "with an array of roman and arabic numbers and invalid characters" do
      let(:array_of_numbers) { ["III", 29, 38, "CCXCI", 1999, 15, ","] }

      it "converts roman numerals to arabic and arabic to roman" do
        expect(subject.results).to eq([3, "XXIX", "XXXVIII", 291, "MCMXCIX", "XV"])
      end

      it "errors return the invalid characted" do
        expect(subject.errors).to include(",")
      end
    end

    context "with an empty array" do
      let(:array_of_numbers) { [] }

      it "retuns an error message" do
        expect(subject.error_messages).to include("Did not allow to perform")
      end
    end
  end

  context "#is_arabic?" do
    context "with an integer" do
      it { expect(described_class.new(nil).send(:is_arabic?, 1)).to be_truthy }
    end

    context "with a invalid string" do
      it { expect(described_class.new(nil).send(:is_arabic?, "XXXVIII")).to be_falsey }
    end

    context "with a valid string" do
      it { expect(described_class.new(nil).send(:is_arabic?, "1")).to be_truthy }
    end
  end

  context "#is_roman?" do
    context "with an integer" do
      it { expect(described_class.new(nil).send(:is_roman?, 1)).to be_falsey }
    end

    context "with a invalid string" do
      it { expect(described_class.new(nil).send(:is_roman?, "1")).to be_falsey }
    end

    context "with a valid roman numeral" do
      it { expect(described_class.new(nil).send(:is_roman?, "MMXVII")).to be_truthy }
    end
  end

  context "#to_roman" do
    context "with an interger" do
      it { expect(described_class.new(nil).send(:to_roman, 1)).to eq("I") }
    end
  end

  context "#to_arabic" do
    context "with a valid string" do
      it { expect(described_class.new(nil).send(:to_arabic, "X")).to eq(10) }
    end
  end
end