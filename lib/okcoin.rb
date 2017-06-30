require 'websocket'
require 'openssl'
require 'uri'
require 'json'
require 'socket'
require 'net/http'
#require 'celluloid/io'

module OKCoin
end

require_relative './okcoin/client'
require_relative './okcoin/future_client'
require_relative './okcoin/spot_client'
require_relative './okcoin/post_request'