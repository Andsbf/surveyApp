class Form
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: String, default: "draft"
  field :title, type: String, default: "untitled"

  has_many :rows, dependent: :destroy

end
