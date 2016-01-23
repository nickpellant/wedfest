Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do
    Invite.find_by(
      invite_code: params[:password], email_address: params[:username]
    )
  end
end

Doorkeeper.configuration.token_grant_types << 'password'
