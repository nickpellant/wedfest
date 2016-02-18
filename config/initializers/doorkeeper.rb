Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do
    invite = Invite.find_by(invite_code: params[:password])
    return unless invite

    invite.update(email_address: params[:username])
    invite
  end
end

Doorkeeper.configuration.token_grant_types << 'password'
