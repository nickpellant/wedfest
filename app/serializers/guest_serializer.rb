class GuestSerializer < ActiveModel::Serializer
  attributes :id, :attendance, :diet, :name

  belongs_to :invite
end
