# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Http do
  it 'has a version number' do
    expect(Legion::Extensions::Http::VERSION).not_to be nil
  end

  describe '.default_settings' do
    subject(:defaults) { described_class.default_settings }

    it 'returns a hash with an options key' do
      expect(defaults).to be_a(Hash)
      expect(defaults).to have_key(:options)
    end

    it 'sets open_timeout to 5' do
      expect(defaults[:options][:open_timeout]).to eq(5)
    end

    it 'sets read_timeout to 10' do
      expect(defaults[:options][:read_timeout]).to eq(10)
    end

    it 'sets timeout to 10' do
      expect(defaults[:options][:timeout]).to eq(10)
    end
  end
end
