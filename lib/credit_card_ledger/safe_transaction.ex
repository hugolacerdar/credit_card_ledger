defmodule CreditCardLedger.SafeTransaction do
  use DynamicSupervisor
  alias CreditCardLedger.AccountWorker

  def start_link(args), do: DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def get_or_create_worker(user_id) do
    worker_name = :"AccountWorker.#{user_id}"

    case Process.whereis(worker_name) do
      nil -> DynamicSupervisor.start_child(__MODULE__, {AccountWorker, {user_id, worker_name}})
      pid -> {:ok, pid}
    end
  end
end
