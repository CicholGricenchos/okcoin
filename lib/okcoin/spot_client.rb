class OKCoin::SpotClient < OKCoin::Client
  def initialize
    super('wss://real.okcoin.cn:10440/websocket/okcoinapi')
  end

  def subscribe_depth coin_type: :btc, size: 20
    send(event: 'addChannel', channel: "ok_sub_spotcny_#{coin_type}_depth_#{size}")
    define_handler "ok_sub_spotcny_#{coin_type}_depth_#{size}" do |data|
      yield data
    end
  end
end