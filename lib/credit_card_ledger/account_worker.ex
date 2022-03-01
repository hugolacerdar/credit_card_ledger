defmodule CreditCardLedger.AccountWorker do
  use GenServer
  alias CreditCardLedger.Transaction

  def start_link({user_id, worker_name}) do
    GenServer.start_link(__MODULE__, user_id, name: worker_name)
  end

  def init(_user_id) do
    {:ok, %{}}
  end

  def handle_call({:add_transaction, %{user_id: user_id, amount: amount}}, _from, state) do
    result = Transaction.add_transaction(user_id, amount)
    {:reply, result, state}
  end
end
