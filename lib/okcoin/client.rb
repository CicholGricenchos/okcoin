class OKCoin::Client
  attr_reader :listen_thread

  def initialize url
    @url = url
    @handlers = {}
    connect
  end

  def connected?
    @handshake.finished? && @handshake.valid?
  end

  def connect
    uri = URI.parse @url
    raw_socket = Celluloid::IO::TCPSocket.new(uri.host, uri.port)
    context = OpenSSL::SSL::SSLContext.new(:TLSv1_2)
    @socket = Celluloid::IO::SSLSocket.new(raw_socket, context)
    @socket.connect

    @handshake = WebSocket::Handshake::Client.new url: @url
    @socket.puts @handshake.to_s
    until @handshake.finished?
      @handshake << @socket.gets
    end

    listen
  end

  def send data
    frame = WebSocket::Frame::Outgoing::Client.new(version: @handshake.version, data: data.to_json, type: :text)
    @socket.write frame.to_s
  end

  def listen
    @listen_thread = Thread.new do
      frame = WebSocket::Frame::Incoming::Client.new(version: @handshake.version)
      loop do
        until message = frame.next
          frame << @socket.readpartial(50)
        end

        handle JSON.parse(message.data).first
      end
    end
  end

  def define_handler channel, &block
    @handlers[channel] = block
  end

  def handle message
    @handlers[message["channel"]]&.call(message)
  end

end