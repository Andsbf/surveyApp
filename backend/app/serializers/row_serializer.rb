class RowSerializer < ActiveModel::Serializer
  attributes :id, :options, :label, :row_type, :form_id

  def id
    object.id.to_s
  end

  def form_id
    object.form_id.to_s
  end
end
