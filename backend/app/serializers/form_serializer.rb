class FormSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :rows

  def id
    object.id.to_s
  end
end
