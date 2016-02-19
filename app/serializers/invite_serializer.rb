class InviteSerializer < ActiveModel::Serializer
  attributes :id, :invite_code, :email_address, :name

  belongs_to :current_basket

  has_many :guests
  has_many :orders

  def attributes(*args)
    super.slice(*invite_policy.serialized_attributes)
  end

  def current_basket
    BasketQuery.new.current_basket(invite: object)
  end

  private

  def invite_policy
    InvitePolicy.new(current_invite, object)
  end
end
