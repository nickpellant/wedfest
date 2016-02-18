class IndexInvites < Marmite::Services::IndexEndpoint
  private

  delegate :current_invite, to: :controller

  def resource_scope
    InvitePolicy::Scope.new(current_invite, Invite).resolve
  end
end
