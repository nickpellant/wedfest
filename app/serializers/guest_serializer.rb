class GuestSerializer < ActiveModel::Serializer
  attributes :id, :attendance, :attendance_restriction, :diet, :name

  belongs_to :invite
end
