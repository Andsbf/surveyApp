class ActionBuilder

  def initialize(owner)
    @owner = owner
  end

  def process
    # Currently, the only exports that have actions set are
    # ongoing exports from social campaigns.

    action_attributes = { type: 'ongoing-export' }

    action = @owner.actions.where(action_attributes).first

    @owner.actions.create!(action_attributes) unless action
  end
end
