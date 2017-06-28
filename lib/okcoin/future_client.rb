class OKCoin::FutureClient < OKCoin::Client
  def initialize
    super('wss://real.okex.com:10440/websocket/okexapi')
  end

  def subscribe_depth coin_type: :btc, future_type: :this_week, size: 20
    send(event: 'addChannel', channel: "ok_sub_futureusd_#{coin_type}_depth_#{future_type}_#{size}")
    define_handler "ok_sub_futureusd_#{coin_type}_depth_#{future_type}_#{size}" do |data|
      yield data
    end
  end

  def subscribe_index coin_type: :btc
    send(event: 'addChannel', channel: "ok_sub_futureusd_#{coin_type}_index")
    define_handler "ok_sub_futureusd_#{coin_type}_index" do |data|
      yield data
    end
  end
end