class Account < ApplicationRecord
  belongs_to :client
  has_many :transactions
  before_validation :generate_account_number, on: :create
  before_validation :set_default_value, on: :create

  # Verifica se o número da conta não é repetido
  validates :account_number, presence: true, uniqueness: true

  validates :current_value, numericality: { greater_than_or_equal_to: 0 }

  # Método para gerar um número de conta alfanumérico único
  def generate_account_number
    loop do
      self.account_number = SecureRandom.alphanumeric(10).upcase
      break unless Account.exists?(account_number: account_number)
    end
  end

  def set_default_value
    self.current_value ||= 0.0
  end
end
