class Account < ApplicationRecord
  has_many :transactions
  has_one_attached :document_image
  before_validation :generate_account_number, :set_creation_date, :generate_password, :set_default_value, on: :create

  validate :validate_doc_number

  validate :verificacao_de_idade

  # Validação para garantir que a imagem foi anexada
  validates :document_image, presence: true

  # Custom validation to ensure document_image is attached
  validate :document_image_presence

  # Validação personalizada para garantir que o nome tenha pelo menos um nome e um sobrenome
  validate :verificacao_de_nome_e_sobrenome

  enum doc_type: { cpf: "CPF", rg: "RG" }

  # Validação para o campo nome
  validates :name, presence: true,
  length: { maximum: 50 },
  format: { with: /\A[a-zA-Z\s]+\z/, message: "deve conter apenas letras e espaços." },
  uniqueness: { case_sensitive: false, message: "Este usuário já existe." }

  # Verifica se a data de abertura da conta foi registrada
  validates :registration_date, presence: true

  # Validação para o tipo de documento
  validates :doc_type, presence: true

  # Validações para o número do documento
  validates :doc_number, presence: true,
   length: { minimum: 9, maximum: 11 },
   numericality: { only_integer: true, message: "deve conter apenas números" },
   uniqueness: { case_sensitive: false, message: "Este documento já pertence a um usuário" }

  # Validação para a data de nascimento
  validates :birth_date, presence: true

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

  # altera os tamanhos permitidos dependendo do doc_type, ex: caso seja RG o doc_number deverá ter 9 digitos
  def validate_doc_number
    if doc_number.present?
      case doc_type
      when "CPF"
        errors.add(:doc_number, "deve conter exatamente 11 dígitos para CPF.") unless doc_number.length == 11
      when "RG"
        errors.add(:doc_number, "deve conter exatamente 9 dígitos para RG.") unless doc_number.length == 9
      end
    end
  end

  def verificacao_de_idade
    return unless birth_date.present? && birth_date > 18.years.ago.to_date
    errors.add(:birth_date, "O usuário não pode ser menor de 18 anos.")
  end

  def set_creation_date
    self.registration_date = Time.current
  end

  def verificacao_de_nome_e_sobrenome
    if name.present?
      parts = name.split
      errors.add(:name, "deve conter pelo menos um nome e um sobrenome.") if parts.size < 2
    else
      errors.add(:name, "não pode ser em branco.")
    end
  end

  def generate_password
    self.password = SecureRandom.hex(8)
  end

  def set_default_value
    self.current_value ||= 0.0
  end

  def document_image_presence
    unless document_image.attached?
      errors.add(:document_image, "deve ser anexada.")
    end
  end
end
