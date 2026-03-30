# frozen_string_literal: true

require 'spec_helper'
require 'faraday'
require 'legion/extensions/http/runners/http'

RSpec.describe Legion::Extensions::Http::Runners::Http do
  # ---------------------------------------------------------------------------
  # Test host class: includes the runner and provides a settings stub so the
  # runner methods can read open_timeout / timeout without the full framework.
  # ---------------------------------------------------------------------------
  let(:runner_class) do
    Class.new do
      include Legion::Extensions::Http::Runners::Http

      def settings
        { options: { open_timeout: 5, timeout: 10 } }
      end
    end
  end

  let(:runner) { runner_class.new }

  # ---------------------------------------------------------------------------
  # Faraday fakes
  #
  # The runner creates a connection via:
  #   Faraday.new(host) { |c| c.options[...] = ...; c.port = ...; c.response ... }
  #
  # The builder block receives `fake_builder`.  After the block, Faraday.new
  # returns `fake_conn`, which is the object the runner calls the HTTP verb on.
  #
  # Separating builder from connection prevents conflicts with the `#options`
  # HTTP verb method sharing a name with the Faraday builder's `#options` accessor.
  # ---------------------------------------------------------------------------
  let(:builder_opts) { {} }

  let(:fake_builder) do
    b = double('FaradayBuilder')
    allow(b).to receive(:options).and_return(builder_opts)
    allow(b).to receive(:port=)
    allow(b).to receive(:response)
    b
  end

  let(:fake_request) do
    req = double('FaradayRequest')
    allow(req).to receive(:params=)
    allow(req).to receive(:body=)
    allow(req).to receive(:url)
    req
  end

  let(:response_hash) do
    { status: 200, body: { 'result' => 'ok' }, headers: {}, env: nil, reason_phrase: nil }
  end

  let(:fake_response) do
    resp = double('FaradayResponse')
    allow(resp).to receive(:to_hash).and_return(response_hash)
    resp
  end

  let(:fake_conn) do
    conn = double('FaradayConnection')
    %i[get post put patch delete head].each do |verb|
      allow(conn).to receive(verb).and_yield(fake_request).and_return(fake_response)
    end
    # The HTTP OPTIONS verb method on the connection object
    allow(conn).to receive(:options).and_yield(fake_request).and_return(fake_response)
    conn
  end

  before do
    # Faraday.new(host, &builder_block) -> yields fake_builder to the block,
    # then returns fake_conn as the built connection.
    allow(Faraday).to receive(:new) do |_url, &blk|
      blk.call(fake_builder)
      fake_conn
    end
  end

  # ---------------------------------------------------------------------------
  describe '#status' do
    it 'returns { test: true } without making any HTTP connection' do
      expect(runner.status).to eq({ test: true })
      expect(Faraday).not_to have_received(:new)
    end
  end

  # ---------------------------------------------------------------------------
  describe '#get' do
    it 'calls Faraday.new with the given host' do
      runner.get(host: 'http://example.com')
      expect(Faraday).to have_received(:new).with('http://example.com')
    end

    it 'sets open_timeout on the builder options' do
      runner.get(host: 'http://example.com')
      expect(builder_opts[:open_timeout]).to eq(5)
    end

    it 'sets timeout on the builder options' do
      runner.get(host: 'http://example.com')
      expect(builder_opts[:timeout]).to eq(10)
    end

    it 'sets the port on the builder' do
      runner.get(host: 'http://example.com', port: 8080)
      expect(fake_builder).to have_received(:port=).with(8080)
    end

    it 'defaults port to 80' do
      runner.get(host: 'http://example.com')
      expect(fake_builder).to have_received(:port=).with(80)
    end

    it 'returns the response as a hash' do
      result = runner.get(host: 'http://example.com', uri: '/path')
      expect(result).to be_a(Hash)
      expect(result[:status]).to eq(200)
    end

    it 'uses the provided uri' do
      runner.get(host: 'http://example.com', uri: '/api/v1')
      expect(fake_conn).to have_received(:get).with('/api/v1')
    end

    it 'defaults uri to empty string' do
      runner.get(host: 'http://example.com')
      expect(fake_conn).to have_received(:get).with('')
    end

    it 'sets params on the request when provided' do
      runner.get(host: 'http://example.com', params: { q: 'test' })
      expect(fake_request).to have_received(:params=).with({ q: 'test' })
    end

    it 'does not set params when not provided' do
      runner.get(host: 'http://example.com')
      expect(fake_request).not_to have_received(:params=)
    end

    it 'sets body on the request when provided' do
      runner.get(host: 'http://example.com', body: 'payload')
      expect(fake_request).to have_received(:body=).with('payload')
    end

    it 'does not set body when not provided' do
      runner.get(host: 'http://example.com')
      expect(fake_request).not_to have_received(:body=)
    end

    it 'registers json response middleware' do
      runner.get(host: 'http://example.com')
      expect(fake_builder).to have_received(:response).with(:json, content_type: /\bjson$/)
    end
  end

  # ---------------------------------------------------------------------------
  describe '#post' do
    it 'calls Faraday.new with the given host' do
      runner.post(host: 'http://example.com')
      expect(Faraday).to have_received(:new).with('http://example.com')
    end

    it 'returns the response as a hash' do
      result = runner.post(host: 'http://example.com', uri: '/submit')
      expect(result).to be_a(Hash)
      expect(result[:status]).to eq(200)
    end

    it 'defaults uri to empty string' do
      runner.post(host: 'http://example.com')
      expect(fake_conn).to have_received(:post).with('')
    end

    it 'sets params when provided' do
      runner.post(host: 'http://example.com', params: { a: '1' })
      expect(fake_request).to have_received(:params=).with({ a: '1' })
    end

    it 'sets body when provided' do
      runner.post(host: 'http://example.com', body: '{"key":"value"}')
      expect(fake_request).to have_received(:body=).with('{"key":"value"}')
    end

    it 'calls req.url with the uri' do
      runner.post(host: 'http://example.com', uri: '/endpoint')
      expect(fake_request).to have_received(:url).with('/endpoint')
    end

    it 'does not set params when not provided' do
      runner.post(host: 'http://example.com')
      expect(fake_request).not_to have_received(:params=)
    end
  end

  # ---------------------------------------------------------------------------
  describe '#patch' do
    it 'returns the response as a hash' do
      result = runner.patch(host: 'http://example.com', uri: '/resource/1')
      expect(result).to be_a(Hash)
    end

    it 'defaults uri to empty string' do
      runner.patch(host: 'http://example.com')
      expect(fake_conn).to have_received(:patch).with('')
    end

    it 'sets body when provided' do
      runner.patch(host: 'http://example.com', body: 'update')
      expect(fake_request).to have_received(:body=).with('update')
    end

    it 'does not set body when not provided' do
      runner.patch(host: 'http://example.com')
      expect(fake_request).not_to have_received(:body=)
    end

    it 'calls req.url with the uri' do
      runner.patch(host: 'http://example.com', uri: '/resource/1')
      expect(fake_request).to have_received(:url).with('/resource/1')
    end
  end

  # ---------------------------------------------------------------------------
  describe '#put' do
    it 'defaults uri to /' do
      runner.put(host: 'http://example.com')
      expect(fake_conn).to have_received(:put).with('/')
    end

    it 'returns the response as a hash' do
      result = runner.put(host: 'http://example.com', uri: '/resource')
      expect(result).to be_a(Hash)
    end

    it 'sets body when provided' do
      runner.put(host: 'http://example.com', body: 'full_payload')
      expect(fake_request).to have_received(:body=).with('full_payload')
    end

    it 'does not set params when not provided' do
      runner.put(host: 'http://example.com')
      expect(fake_request).not_to have_received(:params=)
    end
  end

  # ---------------------------------------------------------------------------
  describe '#delete' do
    it 'defaults uri to /' do
      runner.delete(host: 'http://example.com')
      expect(fake_conn).to have_received(:delete).with('/')
    end

    it 'returns the response as a hash' do
      result = runner.delete(host: 'http://example.com', uri: '/resource/99')
      expect(result).to be_a(Hash)
    end

    it 'does not set params when not provided' do
      runner.delete(host: 'http://example.com')
      expect(fake_request).not_to have_received(:params=)
    end

    it 'sets params when provided' do
      runner.delete(host: 'http://example.com', params: { id: 42 })
      expect(fake_request).to have_received(:params=).with({ id: 42 })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#head' do
    it 'defaults uri to /' do
      runner.head(host: 'http://example.com')
      expect(fake_conn).to have_received(:head).with('/')
    end

    it 'returns the response as a hash' do
      result = runner.head(host: 'http://example.com')
      expect(result).to be_a(Hash)
    end

    it 'does not set body when not provided' do
      runner.head(host: 'http://example.com')
      expect(fake_request).not_to have_received(:body=)
    end
  end

  # ---------------------------------------------------------------------------
  describe '#options' do
    it 'defaults uri to /' do
      runner.options(host: 'http://example.com')
      expect(fake_conn).to have_received(:options).with('/')
    end

    it 'uses the provided uri' do
      runner.options(host: 'http://example.com', uri: '/capabilities')
      expect(fake_conn).to have_received(:options).with('/capabilities')
    end

    it 'returns the response as a hash' do
      result = runner.options(host: 'http://example.com')
      expect(result).to be_a(Hash)
    end
  end
end
