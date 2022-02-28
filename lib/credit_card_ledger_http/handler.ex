defmodule CreditCardLedgerHTTP.Handler do
  import Plug.Conn

  def index(conn) do
    conn
    |> put_resp_content_type("application/json; charset=utf-8")
    |> send_resp(:ok, "eita oi")
  end
end
