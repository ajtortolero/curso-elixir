defmodule AppArtistPainting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AppArtistPaintingWeb.Telemetry,
      # Start the Ecto repository
      AppArtistPainting.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: AppArtistPainting.PubSub},
      # Start the Endpoint (http/https)
      AppArtistPaintingWeb.Endpoint
      # Start a worker by calling: AppArtistPainting.Worker.start_link(arg)
      # {AppArtistPainting.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AppArtistPainting.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AppArtistPaintingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
