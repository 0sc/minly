class UrlSerializer < ActiveModel::Serializer
  attributes :id, :active, :views

  def attributes
  data = super
  if !data
  end

end
