require 'spec_helper'
require_relative '../../services/base_service'

describe Services::BaseService do
  describe "::perform" do
    subject { described_class.perform(nil) }

    it 'raise NoMethodError' do
      expect{subject}.to raise_error(NoMethodError)
    end
  end

  describe "#perform" do
    subject { service_object.perform }
    let(:service_object) { described_class.new(nil) }

    it 'raise NoMethodError' do
      expect{subject}.to raise_error(NoMethodError)
    end
  end
end