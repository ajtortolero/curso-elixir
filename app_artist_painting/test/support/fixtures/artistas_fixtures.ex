defmodule AppArtistPainting.ArtistasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AppArtistPainting.Artistas` context.
  """

  @doc """
  Generate a artista.
  """
  def artista_fixture(attrs \\ %{}) do
    {:ok, artista} =
      attrs
      |> Enum.into(%{
        documento: "some documento",
        nombre: "some nombre",
        fecha_nacimiento: ~D[2023-09-13],
        nacionalidad: "some nacionalidad",
        sexo: "some sexo"
      })
      |> AppArtistPainting.Artistas.create_artista()

    artista
  end
end
