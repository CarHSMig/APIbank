class Client < ApplicationRecord
  # has_secure_password
  before_validation :generate_password, on: :create
  enum doc_type: { cpf: 0, rg: 1 }

  # Validação para o campo nome
  validates :name, presence: true,
    length: { maximum: 50 },
    format: { with: /\A[a-zA-Z\s]+\z/, message: "deve conter apenas letras e espaços." },
    uniqueness: { case_sensitive: false, message: "Este usuário já existe." }

  # Validação personalizada para garantir que o nome tenha pelo menos um nome e um sobrenome
  validate :verificacao_de_nome_e_sobrenome

  def verificacao_de_nome_e_sobrenome
    if name.present?
      parts = name.split
      errors.add(:name, "deve conter pelo menos um nome e um sobrenome.") if parts.size < 2
    else
      errors.add(:name, "não pode ser em branco.")
    end
  end

  private
  def generate_password
    self.password = SecureRandom.hex(8)
  end

  # Em caso de permitir que o usuario crie a senha isso será um verificador para análisar se o mesmo seguiu as regras de criação da senha
  # Validação para a senha, para verificar se a mesma possui letras minusculas, maíusculas, números e símbolos
  # validates :password, presence: true,
  #   length: { minimum: 8 },
  #   format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}/,
  #   message: "deve conter pelo menos 8 caracteres, com pelo menos uma letra maiúscula, uma letra minúscula, um número e um símbolo." }

  # Validação para o tipo de documento
  validates :doc_type, presence: true,
    length: { minimum: 0, maximum: 1 },
    numericality: { only_integer: true, message: "Selecione o tipo de documento" }

  # altera os tamanhos permitidos dependendo do doc_type, ex: caso seja RG o doc_number deverá ter 9 digitos

  # Validações para o número do documento
  validates :doc_number, presence: true,
    length: { minimum: 9, maximum: 11 },
    numericality: { only_integer: true, message: "deve conter apenas números" },
    uniqueness: { case_sensitive: false, message: "Este documento já pertence a um usuário" }


  def validate_doc_number
    if doc_number.present?
      case doc_type
      when "cpf"
        unless doc_number.length == 11
          errors.add(:doc_number, "deve conter exatamente 11 dígitos para CPF.")
        end
      when "rg"
        unless doc_number.length == 9
          errors.add(:doc_number, "deve conter exatamente 9 dígitos para RG.")
        end
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

  # Validação para a imagem do documento
  # has_one_attached :document_image
  # validates :document_image, attached: true, blob: {
  #   content_type: [ "image/jpeg", "image/png" ],
  #   size_range: 1..10.megabytes,
  #   message: "deve ser uma imagem JPEG ou PNG e ter entre 1 byte e 10 megabytes"
  #   }
end
