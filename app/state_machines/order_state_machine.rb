class OrderStateMachine
  include Statesman::Machine

  state :ordered, initial: true
  state :payment_received

  transition from: :ordered, to: :payment_received

  guard_transition(to: :payment_received) do |order|
    order.stripe_token.present?
  end

  before_transition(to: :payment_received) do |order, _transition|
    ChargeOrder.new(order: order).call
  end
end
