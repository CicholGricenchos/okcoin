class OKCoin::PostRequest
  def initialize url, params
    @url = url
    @secret_key = params.delete(:secret_key)
    @params = params
  end

  def perform
    uri = URI.parse(@url)
    request = Net::HTTP::Post.new(uri.path)

    string_to_sign = @params.sort_by{|k, _| k}.concat([[:secret_key, @secret_key]]).map{|k, v| "#{k}=#{v}"}.join('&')
    sign = Digest::MD5.hexdigest(string_to_sign).upcase

    request.set_form_data(
      **@params,
      sign: sign
    )

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, open_timeout: 1, read_timeout: 1) do |http|
      http.request request
    end
  end
end
