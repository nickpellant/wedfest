class Guest < ActiveRecord::Base
  validates :invite, :name, presence: true

  belongs_to :invite
end
