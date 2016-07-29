# This class get the leads for a source object, if cids get passed in
# leads will be fetched based on the cids otherwise it will be fetched
# from object node satisfied_cids. Class works for any object that
# respondes to object.satisfied_cids(hasBetaNode) and has a merchant

class LeadsGetter

  def initialize(source, cids = [])
    @source = source
    @cids = cids.presence || satisfied_cids
  end

  def process
    merchant.unlimited_leads? ? leads : leads.not_limited
  end

  private

  def leads
    Lead.where(mid: merchant.id, :cid.in => @cids)
  end

  def merchant
    @merchant ||= @source.merchant
  end

  def satisfied_cids
    @source.satisfied_cids
  end
end
