defmodule AppArtistPainting.Repo do
  use Ecto.Repo,
    otp_app: :app_artist_painting,
    adapter: Ecto.Adapters.Postgres
end
