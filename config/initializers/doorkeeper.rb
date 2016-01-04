Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do
    invite = Invite.includes(:guests).find_by(invite_code: params[:invite_code])
    invite.guests.find_by(
      id: params[:guest_id], email: params[:guest_email_address]
    )
  end
end
