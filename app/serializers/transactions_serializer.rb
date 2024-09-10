class TransactionsSerializer
  include JSONAPI::Serializer
  attributes :transaction_type, :value, :balance_before, :new_balance, :transaction_date, :description
end
