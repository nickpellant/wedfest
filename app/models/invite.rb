class Invite < ActiveRecord::Base
  validates :invite_code, presence: true, uniqueness: { case_sensitive: false }

  has_many :guests
  has_many :baskets
end
