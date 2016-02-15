class InvitePolicy < ApplicationPolicy
  def serialized_attributes
    keys = [:invite_code]
    keys << :email_address if current_invite?

    keys.sort_by(&:downcase)
  end

  private

  def current_invite?
    record == invite
  end
end
