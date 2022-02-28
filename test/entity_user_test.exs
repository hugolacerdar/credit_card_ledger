defmodule CreditCardLedger.Entity.UserTest do
  use ExUnit.Case
  alias CreditCardLedger.Entity.User
  alias CreditCardLedger.Repo

  test "save a user to the database" do
    params = %{
      fullname: "Joe Doe"
    }

    params
    |> User.cast()
    |> Repo.insert()

    users = Repo.all(User)

    assert [%User{}] = users
  end
end
