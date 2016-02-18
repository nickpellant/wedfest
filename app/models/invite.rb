class Invite < ActiveRecord::Base
  validates :email_address, format: { with: /@/, allow_nil: true }
  validates :invite_code, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  has_many :baskets
  has_many :guests
  has_many :orders
end
