defmodule CreditCardLedger.Entity.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias CreditCardLedger.Entity.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "transactions" do
    field :amount, :integer
    belongs_to(:user, User)
    field :inserted_at, :naive_datetime
  end

  def cast(params, user) do
    truncated_now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    %__MODULE__{inserted_at: truncated_now}
    |> cast(params, [:amount])
    |> validate_required([:amount])
    |> put_assoc(:user, user)
  end
end
