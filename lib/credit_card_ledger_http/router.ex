defmodule CreditCardLedgerHTTP.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:fetch_query_params)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  post("/transaction", do: CreditCardLedgerHTTP.Handler.handle_transaction(conn))
end
