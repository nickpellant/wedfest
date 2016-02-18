class InvitePolicy
  class Scope
    attr_reader :invite, :scope

    def initialize(invite, scope)
      @invite = invite
      @scope = scope
    end

    def resolve
      return scope.none unless invite
      scope.where(invite_code: invite.invite_code)
    end
  end
end
