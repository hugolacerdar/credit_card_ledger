defmodule CreditCardLedger.Application do
  @moduledoc false
  require Logger
  use Application
  @http_port 8081

  @impl true
  def start(_type, _args) do
    Logger.info("Starting http server at port #{@http_port}")
    children = [
      CreditCardLedger.Repo,
      {Plug.Cowboy, scheme: :http, plug: CreditCardLedgerHTTP.Router, options: [port: @http_port]},
      CreditCardLedger.SafeTransaction
    ]

    opts = [strategy: :one_for_one, name: CreditCardLedger.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
