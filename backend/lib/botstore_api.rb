class BotstoreApi
  attr_reader :url

  def self.botstore_url
    case Rails.env.to_s
    when 'test', 'development'
      'https://botstore.lvh.me'
    when 'staging'
      raise "Environment variable BOTSTORE_DOMAIN is missing." unless ENV['BOTSTORE_DOMAIN'].present?
      "https://#{ENV['BOTSTORE_DOMAIN']}"
    when 'production'
      'https://botstore.wishpond.com'
    end
  end

  BOTSTORE_URL = botstore_url

  def self.instance
    BotstoreApi.new(BOTSTORE_URL)
  end

  def initialize(url)
    @url = url
  end

  def qualify(owner)
    external_call(qualify_url(owner))
  end

  def publish(owner)
    external_call(publish_url(owner))['result'.freeze]
  end

  def test_webhook(parameters)
    external_call(test_webhook_url, parameters)
  end

  def merchant_update(mid)
    external_call(merchant_update_url(mid))
  end

  def qualify_url(owner)
    "#{url}/#{resource_name(owner)}/#{owner.id}/qualify?detailed=true"
  end

  def publish_url(owner)
    "#{url}/#{resource_name(owner)}/#{owner.id}/publish"
  end

  def test_webhook_url
    "#{url}/webhooks/test"
  end

  def merchant_update_url(mid)
    "#{url}/merchants/#{mid}"
  end

  private

  def external_call(url, data = nil)
    postfield = Curl::PostField.content('data', data.to_json)
    response = Curl::Easy.http_post(url, postfield) do |curl|
      curl.ssl_verify_host = 0
    end

    if response.response_code == 200
      JSON.parse(response.body_str)
    else
      raise response.body_str
    end
  end

  def resource_name(owner)
    owner.class.to_s.underscore.pluralize
  end

end
