class GuestSerializer < ActiveModel::Serializer
  attributes :id, :attendance, :name

  belongs_to :invite
end
