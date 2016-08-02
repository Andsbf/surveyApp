class RowSerializer < ActiveModel::Serializer
  attributes :id, :options, :label, :field_type

  def id
    object.id.to_s
  end
end
