defmodule AppArtistPainting.Repo.Migrations.CreatePinturas do
  use Ecto.Migration

  def change do
    create table(:pinturas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :titulo, :string
      add :anio_creacion, :integer
      add :estilo_pintura, :string
      add :artista_id, references(:artistas, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end
  end
end
