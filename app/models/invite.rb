class Invite < ActiveRecord::Base
  validates :invite_code, presence: true, uniqueness: { case_sensitive: false }
end
