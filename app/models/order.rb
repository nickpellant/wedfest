class Order < ActiveRecord::Base
  belongs_to :basket
  belongs_to :invite

  has_many :order_charges
  has_many :order_items
  has_many :order_transitions, autosave: false

  validates :basket, :invite, presence: true

  monetize :total_price_pence, numericality: { greater_than_or_equal_to: 0 }

  def state_machine
    @state_machine ||= OrderStateMachine.new(
      self, transition_class: OrderTransition
    )
  end
end
