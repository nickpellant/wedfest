class InviteSerializer < ActiveModel::Serializer
  attributes :id, :invite_code

  belongs_to :current_basket

  has_many :guests

  def current_basket
    BasketQuery.new.current_basket(invite: object)
  end
end
