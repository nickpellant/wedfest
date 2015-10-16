class InviteSerializer < ActiveModel::Serializer
  attributes :id, :invite_code

  has_many :guests
end
