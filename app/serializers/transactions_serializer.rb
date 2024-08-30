class TransactionsSerializer
  include JSONAPI::Serializer
  attributes :transaction_type, :value, :transaction_date, :description
end
