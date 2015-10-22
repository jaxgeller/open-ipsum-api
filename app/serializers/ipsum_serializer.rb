class IpsumSerializer < ActiveModel::Serializer
  attributes :title, :text, :g_markov
  attribute :slug, key: :id
  belongs_to :user
end
