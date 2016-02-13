class Basket < ActiveRecord::Base
  belongs_to :invite

  has_many :basket_items
  has_many :basket_transitions, autosave: false

  validates :invite, presence: true

  def state_machine
    @state_machine ||= BasketStateMachine.new(
      self, transition_class: BasketTransition
    )
  end
end
