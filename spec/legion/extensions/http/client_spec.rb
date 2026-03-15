# frozen_string_literal: true

require 'spec_helper'
require 'faraday'
require 'legion/extensions/http/client'

RSpec.describe Legion::Extensions::Http::Client do
  describe '#initialize' do
    it 'stores default options' do
      client = described_class.new
      expect(client.opts).to include(open_timeout: 5, read_timeout: 10, timeout: 10, port: 80)
    end

    it 'accepts custom timeout options' do
      client = described_class.new(open_timeout: 10)
      expect(client.opts[:open_timeout]).to eq(10)
    end

    it 'accepts custom port' do
      client = described_class.new(port: 443)
      expect(client.opts[:port]).to eq(443)
    end

    it 'stores extra keyword arguments' do
      client = described_class.new(custom_key: 'value')
      expect(client.opts[:custom_key]).to eq('value')
    end
  end

  describe '#settings' do
    it 'exposes opts under :options key for runner compatibility' do
      client = described_class.new
      expect(client.settings[:options]).to include(open_timeout: 5, timeout: 10)
    end
  end

  describe '#connection' do
    it 'builds a Faraday connection' do
      client = described_class.new
      conn = client.connection(host: 'http://example.com')
      expect(conn).to be_a(Faraday::Connection)
    end

    it 'allows per-call overrides' do
      client = described_class.new(open_timeout: 5)
      conn = client.connection(host: 'http://example.com', open_timeout: 30)
      expect(conn.options.open_timeout).to eq(30)
    end
  end

  describe 'runner method availability' do
    let(:client) { described_class.new }

    it 'responds to all HTTP verb methods' do
      expect(client).to respond_to(:get, :post, :put, :patch, :delete, :head, :options, :status)
    end

    it 'returns { test: true } from status' do
      expect(client.status).to eq({ test: true })
    end
  end
end
