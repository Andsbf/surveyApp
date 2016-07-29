class LeadCounterCache
  THRESHOLD = 10_000
  LENGTH = 5.minutes

  def initialize(merchant, key = nil, list_id = nil)
    @merchant = merchant
    @key = key.to_s
    @list_id = list_id.presence
  end

  def cache(lead_count)
    Rails.cache.write(cache_key, lead_count, expires_in: LENGTH)
    @merchant.approximate_lead_counts[source_key] = lead_count
    @merchant.save
    lead_count
  end

  def cached_count
    @cached_count ||= Rails.cache.read(cache_key)
  end

  def source_key
    @list_id ? "#{@key}/#{@list_id}" : @key
  end

  def busy?
    caching? || !caching!
  end

  def bust
    keys = Redis.current.keys("#{Rails.cache.options[:namespace]}:#{cache_prefix}/*")
    Redis.current.del(keys) if keys.any?
    :busted
  end

  private

  def caching?
    Redis.current.get(caching_key).present?
  end

  def caching!
    if Redis.current.setnx(caching_key, 1) == 0
      false
    else
      Redis.current.expire(caching_key, LENGTH)
    end
  end

  def cache_prefix
    @cache_prefix ||= "count_cache/#{@merchant.id}"
  end

  def cache_key
    @cache_key ||= "#{cache_prefix}/#{@key}_count/#{@list_id}"
  end

  def caching_key
    @caching_key ||= "caching-#{cache_key}"
  end
end
