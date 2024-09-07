class Transaction < ApplicationRecord
  belongs_to :account
  before_validation :set_creation_date, on: :create

  enum transaction_type: { debit: "debit", credit: "credit" }

  validates :value, presence: true, numericality: { greater_than: 0 }, format: { with: /\A\d+(\.\d{1,2})?\z/, message: "deve ter no máximo dois dígitos após a vírgula." }

  validates :description,
    length: { maximum: 150 },
    format: { with: /\A[a-zA-Z\s]+\z/, message: "deve conter apenas letras e espaços." },
    allow_blank: true

  validates :transaction_type, presence: true

  def set_creation_date
    self.transaction_date = Time.current
  end
end
