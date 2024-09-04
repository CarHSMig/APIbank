class AccountsController < ApplicationController
  def create
    account = Account.new(account_params)
    if account.save
      account = account.create_account
      render json: { account: account, password: account.generate_password }, status: :created
    else
      render json: { errors: account.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    account = Account.find(params[:id])
    render json: { account: AccountsSerializer.new(account).serializable_hash }, status: :ok
  end

  private

  def account_params
    params.require(:account).permit(:name, :doc_number, :doc_type, :birth_date)
  end
end
