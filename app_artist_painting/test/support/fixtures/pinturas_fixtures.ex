defmodule AppArtistPainting.PinturasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AppArtistPainting.Pinturas` context.
  """

  @doc """
  Generate a pintura.
  """
  def pintura_fixture(attrs \\ %{}) do
    {:ok, pintura} =
      attrs
      |> Enum.into(%{
        titulo: "some titulo",
        anio_creacion: 42,
        estilo_pintura: "some estilo_pintura"
      })
      |> AppArtistPainting.Pinturas.create_pintura()

    pintura
  end
end
