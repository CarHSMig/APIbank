class ClientsSerializer
  include JSONAPI::Serializer
  attributes :name, :password, :birth_date, :doc_type, :doc_number, :registration_date

  attribute :document_image_url do |client|
    Rails.application.routes.url_helpers.rails_blob_url(client.document_image, only_path: true) if client.document_image.attached?
  end
end

