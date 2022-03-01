defmodule CreditCardLedgerHTTP.Handler do
  import Plug.Conn
  alias CreditCardLedger.SafeTransaction
  alias CreditCardLedger.Entity.Transaction

  def handle_transaction(conn) do
    { status, body } = case conn.body_params do
      %{"user_id" => user_id, "amount" => amount} -> transaction(user_id, amount)
      _ -> {422, missing_params()}
    end

    conn
    |> put_resp_content_type("application/json; charset=utf-8")
    |> send_resp(status, body)
  end

  defp transaction(user_id, amount) do
    {status, result} = case SafeTransaction.add_transaction(user_id, amount) do
      {:ok, %Transaction{amount: amount, id: id, inserted_at: inserted_at}} -> {:ok, %{amount: amount, id: id, inserted_at: inserted_at}}
      {:error, %{result: reason, status: status}} -> {status, %{error: reason}}
    end

    {status, Poison.encode!(result)}
  end

  defp missing_params do
    Poison.encode!(%{error: "Expected Payload: { 'user_id': 'uuid', amount: 'integer' }"})
  end
end
