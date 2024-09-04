class AccountsSerializer
  include JSONAPI::Serializer
  attributes :name, :birth_date, :doc_type, :doc_number
end
