class LeadLimiter
  def initialize(lead)
    @lead = lead
    @merchant = lead.merchant
  end

  def process
    return :unlimited if @merchant.unlimited_leads?
    set_lead_limit if over_limit?
  end

  private

  def set_lead_limit
    @lead.limited = true
  end

  def over_limit?
    return false if @merchant.unlimited_leads?
    @merchant.leads.count >= @merchant.lead_limit
  end
end
