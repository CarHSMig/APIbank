class TransactionsSerializer
  include JSONAPI::Serializer
  attributes :transaction_type, :value, :balance_before, :transaction_date, :description
end
