class Row
  include Mongoid::Document
  include Mongoid::Timestamps

  field :label, type: String, default: 'draft'
  field :options, type: Array, default: Array.new
  field :row_type, type: String, default: 'dropdown'
  field :postion, type: Number

  belongs_to :form

  validates_presence_of :form
end
