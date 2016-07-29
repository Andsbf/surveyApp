class Row
  include Mongoid::Document
  include Mongoid::Timestamps

  field :label, type: String, default: "draft"
  field :options, type: Hash, default: Hash.new

  belongs_to :form

  validates_presence_of :form

end
