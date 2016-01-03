MoneyRails.configure do |config|
  config.default_currency = :gbp
  config.include_validations = true

  config.amount_column = {
    prefix: '',
    postfix: '_pence',
    column_name: nil,
    type: :integer,
    present: true,
    null: false,
    default: 0
  }

  config.currency_column = { present: false }
end
