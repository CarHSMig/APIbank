class ClientsController < ApplicationController
  def create
    client = Client.new(client_params)
    if client.save
      account = client.create_account
      render json: { client: client, account: account }, status: :created
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
    params.require(:client).permit(:name, :doc_number, :doc_type, :birth_date)
  end
end
