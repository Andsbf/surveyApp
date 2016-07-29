class Mask
  def initialize(owner)
    @owner = owner
  end

  def generate(implicit = false)
    if implicit
      mask = explicit_mask.pad_with('or') + implicit_mask.pad_with('and')
      mask.pad_with('and')
    else
      explicit_mask.pad_with('or')
    end
  end

  # Working with new records here so we cannot use scopes.
  def explicit_mask
    sub_rules = @owner.sub_rules.select do |sub_rule|
      sub_rule.explicit? && requirements(sub_rule).select(&:publishable?).any?
    end

    sub_rules.map do |sub_rule|
      requirements(sub_rule).select(&:publishable?).map do |requirement|
        requirement.mask
      end.pad_with('and')
    end.compact
  end

  # Working with new records here so we cannot use scopes.
  def implicit_mask
    sub_rules = @owner.sub_rules.select do |sub_rule|
      sub_rule.implicit? && requirements(sub_rule).any?
    end

    sub_rules.map do |sub_rule|
      requirements(sub_rule).map do |requirement|
        requirement.mask
      end.pad_with('and')
    end.compact
  end

  private

  def requirements(sub_rule)
    @owner.merchant.requirements.where(sub_rule: sub_rule)
  end
end
