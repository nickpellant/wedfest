class BasketStateMachine
  include Statesman::Machine

  state :active, initial: true
  state :purchased
  state :failed

  transition from: :active, to: %i(purchased failed)
end
