class IpsumSerializer < ActiveModel::Serializer
  attributes :title, :text
  attribute :slug, key: :id
end
