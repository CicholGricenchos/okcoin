require 'minitest/autorun'
require_relative '../lib/okcoin'

class TestClient < Minitest::Test
  def test_handshake
    future_client = OKCoin::FutureClient.new
    assert future_client.connected?
  end

  def test_future_subscribe_depth
    future_client = OKCoin::FutureClient.new

    future_client.subscribe_depth do |data|
      Thread.current[:data] = data
      Thread.current.kill
    end

    thread = future_client.listen_thread

    sleep 0.1 while thread.alive?
    assert thread[:data].is_a?(Hash)
    assert thread[:data].has_key?("data")
  end

  def test_spot_subscribe_depth
    spot_client = OKCoin::SpotClient.new

    spot_client.subscribe_depth do |data|
      Thread.current[:data] = data
      Thread.current.kill
    end

    thread = spot_client.listen_thread

    sleep 0.1 while thread.alive?
    assert thread[:data].is_a?(Hash)
    assert thread[:data].has_key?("data")
  end
end