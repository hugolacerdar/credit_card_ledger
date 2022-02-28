defmodule CreditCardLedger.Entity.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :fullname, :string
    field :credit_limit, :integer
    field :inserted_at, :naive_datetime
  end

  def cast(params) do
    truncated_now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    %__MODULE__{inserted_at: truncated_now}
    |> cast(params, [:fullname, :credit_limit])
    |> validate_required([:fullname])
  end
end
