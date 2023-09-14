defmodule AppArtistPainting.Pinturas.Pintura do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pinturas" do
    field :titulo, :string
    field :anio_creacion, :integer
    field :estilo_pintura, :string
    belongs_to :artista, AppArtistPainting.Artistas.Artista
    timestamps()
  end

  @doc false
  def changeset(pintura, attrs) do
    pintura
    |> cast(attrs, [:titulo, :anio_creacion, :estilo_pintura])
    |> validate_required([:titulo, :anio_creacion, :estilo_pintura])
  end
end
