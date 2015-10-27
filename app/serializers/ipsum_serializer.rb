class IpsumSerializer < ActiveModel::Serializer
  attributes :title, :text, :generated_sample
  attribute :slug, key: :id
  belongs_to :user
end
