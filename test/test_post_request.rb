require 'minitest/autorun'
require_relative '../lib/okcoin'

require 'yaml'

class TestPostRequest < Minitest::Test
  def test_post_request
    keys = YAML.load_file('keys.yml')

    params = {
      symbol: 'ltc_usd',
      contract_type: 'this_week',
      price: '1',
      amount: '1',
      type: '1',
      match_price: '0',
      lever_rate: '10',
      **keys
    }

    response = OKCoin::PostRequest.new('https://www.okex.com/api/v1/future_trade.do', params).perform
    assert_equal '200', response.code
    data = JSON.parse(response.body)
    assert_equal true, data["result"]
  end
end