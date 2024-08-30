class AccountsSerializer
  include JSONAPI::Serializer
  attributes :account_number, :current_value, :opening_date
end
