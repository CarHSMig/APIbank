class ClientsController < ApplicationController
  def create
    client = Client.new(client_params)
    if client.save
      render json: { client: client, password: client.generated_password }, status: :created
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    client = Client.find(params[:id])
    render json: { client: ClientsSerializer.new(client).serializable_hash }, status: :ok
  end

  private

  def client_params
    params.require(:client).permit(:name, :doc_number, :doc_type, :birth_date, :document_image)
  end
end
