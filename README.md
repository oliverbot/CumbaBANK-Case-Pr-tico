# Cumbuca | Case Prático
---
Segue abaixo a documentação básica do funcionamento do projeto desenvolvido, conforme as especificações e regras de negócio definidas anteriormente, para a vaga de Engenheiro de Software Pleno.

### Introdução
---
Eu decidi fazer esse projeto em Elixir utilizando o framework web Phoenix. Apesar da liberdade que eu tive, de escolher qual linguagem ou framework utilizar, acreditei que seria uma desafio maior e mais interessante, considerando que é a linguagem principal usada na Cumbuca. Por outro lado, esse projeto foi um aprendizado e estou feliz de entrega-lo independente de qualquer coisa.

#### Como rodar?
---
```bash
# Primeiramente, clone o repositório.
$ git clone https://github.com/oliverbot/CumbaBANK-Case-Pr-tico.git

# Entre na pasta do projeto.
$ cd CumbaBANK-Case-Pr-tico

# Instale as dependências.
$ mix deps.get

# Configure o banco de dados e rode o seguinte comando.
$ mix ecto.setup
$ mix ecto.migrate

# Inicie o servidor.
$ mix phx.server
```

#### Endpoints
---
##### // Autenticação //

`POST /api/login`
Verifica e-mail e senha e, se corretos, retorna um token jwt.

REQUEST BODY:
```json
{
    "email": :string,
    "password": :string
}
```

##### // Cadastro de conta //
`POST /api/createAccount`
Realiza cadastro de conta de usuário.

REQUEST BODY:
```json
{
    "account": {
        "name": :string,
        "cpf"::string,
        "email": :string,
        "password": :string,
        "initial_balance":decimal
    }
}
```

##### // Cadastro de transação //
`POST /api/transaction`
Realiza operações no saldo das contas envolvidas na transação e cadastra ela no banco.

REQUEST BODY:
```json
{
    "transaction": {
        "amount": :decimal,
        "from_account": :binary_id,
        "to_account": :binary_id
    }
}
```

##### // Visualização de saldo //
`GET /api/getBalance`
Retorna o saldo atual do usuário logado.

##### // Busca de transações por data //
`GET /api/transactions/:initial_date/to/:end_date`
Retorna as transações realizadas entre duas datas específicas.

REQUEST PARAMS:
KEY | VALUE
--- | ---
initial_date | :string (ex: "2022-01-01")
end_date | :string

#### Tecnologias Utilizadas
---
- Elixir
- Phoenix
- PostgreSQL

