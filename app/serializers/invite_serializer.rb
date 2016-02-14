class InviteSerializer < ActiveModel::Serializer
  attributes :id, :email_address, :invite_code

  belongs_to :current_basket

  has_many :guests
  has_many :orders

  def current_basket
    BasketQuery.new.current_basket(invite: object)
  end
end
