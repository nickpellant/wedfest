class Order < ActiveRecord::Base
  belongs_to :basket
  belongs_to :invite

  has_many :order_items
  has_many :order_transitions, autosave: false

  validates :basket, :invite, presence: true

  def state_machine
    @state_machine ||= OrderStateMachine.new(
      self, transition_class: OrderTransition
    )
  end
end
