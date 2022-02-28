defmodule CreditCardLedger.Transaction do
  alias CreditCardLedger.Repo
  alias CreditCardLedger.Entity.{User, Transaction}
  import Ecto.Query

  def add_transaction(user_id, amount) do
    with %User{} = user <- Repo.get(User, user_id),
    used_limit <- get_available_limit(user),
    true <- used_limit + amount <= user.credit_limit do
      Transaction.cast(%{amount: amount}, user)
      |> Repo.insert()

    else
      nil -> {:error, %{result: "User not found", status: :not_found}}
      false -> {:error, %{result: "Not enough credit", status: :bad_request}}
    end
  end

  defp get_available_limit(%{id: user_id}) do
    from(t in Transaction, where: t.user_id == ^user_id, select: sum(t.amount))
    |> Repo.all()
    |> case do
      [nil] -> 0
      [number] -> Decimal.to_integer(number)
      _ -> 0
    end
  end
end
