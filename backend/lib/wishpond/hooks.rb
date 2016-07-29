module Wishpond
  class Hooks
    DEFAULT_HEADERS = {
      'accept' => 'application/json',
      'content-type' => 'application/json; charset=UTF-8'
    }

    def initialize(merchant_id)
      @merchant_id = merchant_id
    end

    def csv_export_complete(url)
      params = {
        merchant_id: @merchant_id,
        url: url
      }.to_json

      response = post(generate_url(:csv_export_complete), params)
      raise response.body if response.code.to_i != 200
    end

    private

    def generate_url(path)
      "#{WISHPOND_URL}/jambo/#{path}"
    end

    def post(url, data)
      uri = URI.parse(url)
      req = Net::HTTP.new(uri.host, uri.port)
      req.use_ssl = uri.scheme == 'https'
      req.post(uri.path, data, DEFAULT_HEADERS)
    end
  end
end
