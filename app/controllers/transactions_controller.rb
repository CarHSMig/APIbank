class TransactionsController < ApplicationController
  def create
    account = Account.find(params[:account_id])
    balance_before = account.current_value
    transaction_type = params[:transaction][:transaction_type]
    value = params[:transaction][:value].to_d

    # Verifica se é debito e se tem dinheiro suficiente
    if transaction_type == "debit"
      if value > balance_before
        return render json: { errors: [ "Saldo insuficiente para a transação" ] }, status: :unprocessable_entity
      end
      final_balance = balance_before - value
    elsif transaction_type == "credit"
      final_balance = balance_before + value
    else
      return render json: { errors: [ "Tipo de transação inválido" ] }, status: :unprocessable_entity
    end

    account.update(current_value: final_balance)

    transaction = account.transactions.create(
    transaction_type: transaction_type,
    balance_before: balance_before,
    new_balance: final_balance,
    value: value,
    description: params[:transaction][:description]
    )

    render json: { transaction: TransactionsSerializer.new(transaction).serializable_hash, current_value: account.current_value }, status: :created
  end

  def index
    account = Account.find(params[:account_id])
    transactions = account.transactions.order(created_at: :desc).page(params[:page])
    render json: {
      account: AccountsSerializer.new(account).serializable_hash, current_value: account.current_value,
      transactions: TransactionsSerializer.new(transactions).serializable_hash
  }, status: :ok
  end

  def show
    account = Account.find(params[:account_id])
    transactions = account.transactions.find(params[:id])
    render json: {
      account: AccountsSerializer.new(account).serializable_hash, current_value: account.current_value,
      transactions: TransactionsSerializer.new(transactions).serializable_hash
  }, status: :ok
  end
end
