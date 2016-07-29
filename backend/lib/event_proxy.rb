class EventProxy
  def initialize(event)
    @mid = event['meta']['mid']
    @email = event['meta']['email']
    @event = event['meta']['event']
    @platform = event['meta']['platform']
    @data = event['data']
  end

  def forward
    if valid?
      Sentry::Handlers::Event.new(
        @mid,
        fetch_cid,
        event_name,
        properties: @data,
        timestamp: Time.now
      ).track
    end
  end

  private

  def event_name
    "#{@platform}_#{@event}"
  end

  def valid?
    @platform.present? && @mid.present? && @email.present? && @event.present?
  end

  def fetch_cid
    fetch_cid_by_email || create_new_cid
  end

  def fetch_cid_by_email
    Lead.where(mid: @mid, email: @email).first.try(:cid)
  end

  def create_new_cid
    SecureRandom.hex(8)
  end
end
