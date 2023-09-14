defmodule AppArtistPainting.Repo.Migrations.CreateArtistas do
  use Ecto.Migration

  def change do
    create table(:artistas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :documento, :string
      add :nombre, :string
      add :fecha_nacimiento, :date
      add :nacionalidad, :string
      add :sexo, :string

      timestamps()
    end

    create unique_index(:artistas, [:documento])
  end
end
