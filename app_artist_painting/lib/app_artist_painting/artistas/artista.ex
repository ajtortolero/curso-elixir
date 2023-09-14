defmodule AppArtistPainting.Artistas.Artista do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "artistas" do
    field :documento, :string
    field :nombre, :string
    field :fecha_nacimiento, :date
    field :nacionalidad, :string
    field :sexo, :string
    has_many :pinturas, AppArtistPainting.Pinturas.Pintura
    timestamps()
  end

  @doc false
  def changeset(artista, attrs) do
    artista
    |> cast(attrs, [:documento, :nombre, :fecha_nacimiento, :nacionalidad, :sexo])
    |> validate_required([:documento, :nombre, :fecha_nacimiento, :nacionalidad, :sexo])
  end
end
