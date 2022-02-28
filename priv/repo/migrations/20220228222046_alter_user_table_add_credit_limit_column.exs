defmodule CreditCardLedger.Repo.Migrations.AlterUserTableAddCreditLimitColumn do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :credit_limit, :integer, nullable: false, default: 0
    end
  end
end
