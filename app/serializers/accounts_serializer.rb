class AccountsSerializer
  include JSONAPI::Serializer
  attributes :name, :birth_date, :doc_type, :doc_number

  attribute :document_image_url do |accounts|
    Rails.application.routes.url_helpers.rails_blob_url(accounts.document_image, only_path: true) if accounts.document_image.attached?
  end
end
