<h1 align="center">APIbank</h1>

<p align="center">API bancária em <b>Ruby on Rails</b>: abertura de contas com documento e movimentações de débito e crédito.</p>

<p align="center">
  <img src="https://img.shields.io/badge/Ruby-3.3.4-CC342D?logo=ruby&logoColor=white" alt="Ruby 3.3.4">
  <img src="https://img.shields.io/badge/Rails-7.1-D30001?logo=rubyonrails&logoColor=white" alt="Rails 7.1">
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/ActiveStorage-docs-555" alt="ActiveStorage">
</p>

---

## Sobre

Projeto de estudo de uma API REST com **regras de negócio no domínio**. Uma conta só é aberta com dados
válidos e foto do documento; cada transação de débito ou crédito atualiza o saldo, que nunca pode ficar negativo.

## Regras de negócio

**Conta**
- Nome com pelo menos nome e sobrenome.
- Documento `CPF` (11 dígitos) ou `RG` (9 dígitos).
- Titular maior de 18 anos.
- Imagem do documento obrigatória (ActiveStorage + ruby-vips).
- Número da conta alfanumérico de 10 caracteres, único, gerado automaticamente.
- Senha gerada no momento da abertura.

**Transação**
- Tipo `debit` ou `credit`.
- Valor positivo, com no máximo duas casas decimais.
- Descrição opcional de até 150 caracteres.
- Saldo da conta nunca negativo.

## Endpoints

| Método | Rota | Descrição |
|---|---|---|
| `POST` | `/accounts` | Abre uma conta (multipart, com `document_image`) |
| `GET` | `/accounts/:id` | Dados da conta |
| `GET` | `/accounts/:account_id/transactions` | Extrato (paginado) |
| `POST` | `/accounts/:account_id/transactions` | Nova transação |
| `GET` | `/accounts/:account_id/transactions/:id` | Detalhe da transação |

Exemplo de transação:

```json
POST /accounts/1/transactions
{
  "transaction": {
    "transaction_type": "debit",
    "value": 150.75,
    "description": "Pagamento mercado"
  }
}
```

## Stack

- **Ruby 3.3.4 / Rails 7.1** (API)
- **PostgreSQL**
- **ActiveStorage** + ruby-vips
- **jsonapi-serializer**, **Kaminari**, **Ransack**, **bcrypt**
- Dockerfile e CI (Brakeman + RuboCop) gerados pelo Rails

## Como rodar

```bash
git clone https://github.com/CarHSMig/APIbank.git
cd APIbank
bundle install
bin/rails db:create db:migrate
bin/rails s
```

## Próximos passos

- [ ] Autenticação das rotas (JWT)
- [ ] Atualização de saldo dentro de transação com lock da conta
- [ ] Specs de models e requests

## Autor

**Carlos Henrique dos Santos Migon** · [LinkedIn](https://www.linkedin.com/in/carlos-henrique-dos-santos-migon-46387b336/) · [GitHub](https://github.com/CarHSMig)
