class GuestSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :invite
end
