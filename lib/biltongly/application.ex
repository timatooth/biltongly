defmodule Biltongly.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BiltonglyWeb.Telemetry,
      Biltongly.Repo,
      {DNSCluster, query: Application.get_env(:biltongly, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Biltongly.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Biltongly.Finch},
      # Start a worker by calling: Biltongly.Worker.start_link(arg)
      # {Biltongly.Worker, arg},
      # Start to serve requests, typically the last entry
      BiltonglyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Biltongly.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BiltonglyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
