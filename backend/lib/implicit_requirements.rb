class ImplicitRequirements
  UnknownSourceTypeError = Class.new(StandardError)

  def initialize(owner)
    @owner = owner
  end

  def process
    destroy_implicit_requirements!

    has_actions_processor if @owner.respond_to?(:actions)
    case @owner
    when Newsletter
      newsletter_processor
    when Export
      export_processor
    end
  end

  def destroy_implicit_requirements!
    @owner.sub_rules.implicit.each(&:destroy)
    @owner.requirements.implicit.each(&:destroy)
  end

  private

  def export_processor
    case @owner.source[:type]
    when 'all'
      create_email_requirement(false)
    when 'list'
      list_requirement_processor
    when 'social_campaign'
      create_social_campaign_requirement
    else
      raise UnknownSourceTypeError.new(@owner.source[:type])
    end
  end

  def list_requirement_processor
    create_list_membership_requirement
    create_email_requirement(false) if @owner.is_a?(Export) && !@owner.csv?
  end

  def social_campaign_requirement_processor
    create_social_campaign_requirement
    social_campaign_email_requirement
  end

  def ongoing_export_processor
    # This reload is needed because this hits in the controller at the same
    # time as a job. Yes, this was built wonderfully.
    email_requirement =
      @owner.reload.requirements.where(
        type: 'lead-property',
        predicate: 'email',
        operator: 'isset'
      )

    create_email_requirement(false) unless email_requirement.first.present?
  end

  def newsletter_processor
    create_email_requirement
    create_subscribed_requirement
  end

  def has_actions_processor
    if @owner.actions.sends_emails.any?
      create_email_requirement
      create_subscribed_requirement
    end
  end

  def create_subscribed_requirement
    sub_rule_attributes = {
      implicit: true
    }

    sub_rule = @owner.sub_rules.where(sub_rule_attributes).first_or_create

    requirement_attributes = {
      implicit: true,
      predicate: 'subscribed',
      operator: 'is',
      type: 'lead-property',
      match_type: 'attribute',
      value: true,
      sub_rule_id: sub_rule.id
    }

    merchant.requirements.create(requirement_attributes)
  end

  def create_email_requirement(implicit = true)
    sub_rule_attributes = {
      implicit: implicit
    }

    sub_rule = @owner.sub_rules.where(sub_rule_attributes).first_or_create

    requirement_attributes = {
      implicit: implicit,
      predicate: 'email',
      operator: 'isset',
      type: 'lead-property',
      match_type: 'attribute',
      sub_rule_id: sub_rule.id
    }

    merchant.requirements.create(requirement_attributes)
  end

  def merchant
    @merchant ||= @owner.merchant
  end

  def create_list_membership_requirement
    sub_rule = @owner.sub_rules.first_or_create

    requirement_attributes = {
      positive: true,
      implicit: false,
      predicate: 'lists',
      operator: 'is',
      type: 'list-membership',
      match_type: 'attribute',
      value: source_id.to_s,
      extras: { name: source_name },
      sub_rule_id: sub_rule.id
    }

    merchant.requirements.create(requirement_attributes)
  end

  def create_social_campaign_requirement
    sub_rule = @owner.sub_rules.first_or_create

    requirement_attributes = {
      positive: true,
      implicit: false,
      predicate: 'participated',
      operator: 'is',
      type: 'campaign-event',
      match_type: 'event',
      value: source_id.to_i,
      extras: { title: source_name },
      sub_rule_id: sub_rule.id
    }

    merchant.requirements.create(requirement_attributes)
  end

  def social_campaign_email_requirement
    case @owner.type
    when 'single'
      create_email_requirement(false)
    when 'ongoing'
      ongoing_export_processor
    end
  end

  def source_name
    @owner.source[:name]
  end

  def source_id
    @owner.source[:id]
  end
end
