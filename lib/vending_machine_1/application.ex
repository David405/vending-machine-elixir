defmodule VendingMachine1.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VendingMachine1Web.Telemetry,
      VendingMachine1.Repo,
      {DNSCluster, query: Application.get_env(:vending_machine_1, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VendingMachine1.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: VendingMachine1.Finch},
      # Start a worker by calling: VendingMachine1.Worker.start_link(arg)
      # {VendingMachine1.Worker, arg},
      # Start to serve requests, typically the last entry
      VendingMachine1Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VendingMachine1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VendingMachine1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
