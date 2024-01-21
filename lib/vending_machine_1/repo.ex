defmodule VendingMachine1.Repo do
  use Ecto.Repo,
    otp_app: :vending_machine_1,
    adapter: Ecto.Adapters.Postgres
end
