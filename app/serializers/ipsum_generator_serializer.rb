class IpsumGeneratorSerializer < ActiveModel::Serializer
  attributes :title, :text, :generated
  attribute :slug, key: :id
end
