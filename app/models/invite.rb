class Invite < ActiveRecord::Base
  validates :invite_code, presence: true, uniqueness: { case_sensitive: false }
  validates :email_address, format: { with: /@/, allow_nil: true }

  has_many :guests
  has_many :baskets
end
