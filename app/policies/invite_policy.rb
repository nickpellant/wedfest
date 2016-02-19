class InvitePolicy < ApplicationPolicy
  def serialized_attributes
    keys = []

    if current_invite?
      keys += [:cabaret_info, :email_address, :invite_code, :name]
    end

    keys.sort_by(&:downcase)
  end

  private

  def current_invite?
    record == invite
  end
end
