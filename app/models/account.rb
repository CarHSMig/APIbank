class Account < ApplicationRecord
  belongs_to :clients
  before_validation :generate_account_number, on: :create
  before_validation :set_default_balance, on: :create

  # Verifica se o número da conta não é repetido
  validates :account_number, presence: true, uniqueness: true

  # Verifica se a data de abertura da conta foi registrada
  validates :opening_date, presence: true

  validates :current_balance, numericality: { greater_than_or_equal_to: 0 }

  # Método para gerar um número de conta alfanumérico único
  def generate_account_number
    loop do
      self.account_number = SecureRandom.alphanumeric(10).upcase
      break unless Account.exists?(account_number: account_number)
    end
  end

  def set_default_balance
    self.current_balance ||= 0.0
  end
end
