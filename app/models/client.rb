class Client < ApplicationRecord
  has_one :account, dependent: :destroy
  after_create :create_account
  before_validation :generate_password, on: :create
  before_validation :set_creation_date, on: :create
  validate :validate_doc_number


  enum doc_type: { cpf: 0, rg: 1 }

  # Validação para o campo nome
  validates :name, presence: true,
    length: { maximum: 50 },
    format: { with: /\A[a-zA-Z\s]+\z/, message: "deve conter apenas letras e espaços." },
    uniqueness: { case_sensitive: false, message: "Este usuário já existe." }

  # Validação personalizada para garantir que o nome tenha pelo menos um nome e um sobrenome
  validate :verificacao_de_nome_e_sobrenome

  # Verifica se a data de abertura da conta foi registrada
  validates :registration_date, presence: true

  # Validação para o tipo de documento
  validates :doc_type, presence: true,
  numericality: { only_integer: true, message: "O tipo de documento deve ser um número inteiro" }

  # Validações para o número do documento
  validates :doc_number, presence: true,
    length: { minimum: 9, maximum: 11 },
    numericality: { only_integer: true, message: "deve conter apenas números" },
    uniqueness: { case_sensitive: false, message: "Este documento já pertence a um usuário" }

  # validate :validate_doc_number
  # altera os tamanhos permitidos dependendo do doc_type, ex: caso seja RG o doc_number deverá ter 9 digitos
  def validate_doc_number
  if doc_number.present?
    case doc_type
    when "cpf"
      errors.add(:doc_number, "deve conter exatamente 11 dígitos para CPF.") unless doc_number.length == 11
    when "rg"
      errors.add(:doc_number, "deve conter exatamente 9 dígitos para RG.") unless doc_number.length == 9
    end
  end
end

  # Validação para a data de nascimento
  validates :birth_date, presence: true

  validate :verificacao_de_idade
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
end
# Validação para a imagem do documento
# has_one_attached :document_image
# validates :document_image, attached: true, blob: {
#   content_type: [ "image/jpeg", "image/png" ],
#   size_range: 1..10.megabytes,
#   message: "deve ser uma imagem JPEG ou PNG e ter entre 1 byte e 10 megabytes"
#   }

# Em caso de permitir que o usuario crie a senha isso será um verificador para análisar se o mesmo seguiu as regras de criação da senha
# Validação para a senha, para verificar se a mesma possui letras minusculas, maíusculas, números e símbolos
# validates :password, presence: true,
#   length: { minimum: 8 },
#   format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}/,
#   message: "deve conter pelo menos 8 caracteres, com pelo menos uma letra maiúscula, uma letra minúscula, um número e um símbolo." }
