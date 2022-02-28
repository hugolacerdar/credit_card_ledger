import Config

config :credit_card_ledger,
    repo: CreditCardLedger.Repo

config :credit_card_ledger, CreditCardLedger.Repo,
    database: "credit_card_ledger_dev",
    username: "root",
    password: "secret",
    hostname: "localhost",
    port: 3306