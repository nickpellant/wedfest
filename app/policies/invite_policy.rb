class InvitePolicy < ApplicationPolicy
  def serialized_attributes
    keys = []
    keys += [:email_address, :invite_code, :name] if current_invite?

    keys.sort_by(&:downcase)
  end

  private

  def current_invite?
    record == invite
  end
end
