class AccountsController < ApplicationController
  def create
    accounts = Accounts.new(accounts_params)
    if accounts.save
      account = accounts.create_account
      render json: {account: account }, status: :created
    else
      render json: { errors: accounts.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    accounts = accounts.find(params[:id])
    render json: { accounts: AccountsSerializer.new(accounts).serializable_hash }, status: :ok
  end

  private

  def accounts_params
    params.require(:accounts).permit(:name, :doc_number, :doc_type, :birth_date)
  end
end
