defmodule AppArtistPainting.ArtistasTest do
  use AppArtistPainting.DataCase

  alias AppArtistPainting.Artistas

  describe "artistas" do
    alias AppArtistPainting.Artistas.Artista

    import AppArtistPainting.ArtistasFixtures

    @invalid_attrs %{documento: nil, nombre: nil, fecha_nacimiento: nil, nacionalidad: nil, sexo: nil}

    test "list_artistas/0 returns all artistas" do
      artista = artista_fixture()
      assert Artistas.list_artistas() == [artista]
    end

    test "get_artista!/1 returns the artista with given id" do
      artista = artista_fixture()
      assert Artistas.get_artista!(artista.id) == artista
    end

    test "create_artista/1 with valid data creates a artista" do
      valid_attrs = %{documento: "some documento", nombre: "some nombre", fecha_nacimiento: ~D[2023-09-13], nacionalidad: "some nacionalidad", sexo: "some sexo"}

      assert {:ok, %Artista{} = artista} = Artistas.create_artista(valid_attrs)
      assert artista.documento == "some documento"
      assert artista.nombre == "some nombre"
      assert artista.fecha_nacimiento == ~D[2023-09-13]
      assert artista.nacionalidad == "some nacionalidad"
      assert artista.sexo == "some sexo"
    end

    test "create_artista/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Artistas.create_artista(@invalid_attrs)
    end

    test "update_artista/2 with valid data updates the artista" do
      artista = artista_fixture()
      update_attrs = %{documento: "some updated documento", nombre: "some updated nombre", fecha_nacimiento: ~D[2023-09-14], nacionalidad: "some updated nacionalidad", sexo: "some updated sexo"}

      assert {:ok, %Artista{} = artista} = Artistas.update_artista(artista, update_attrs)
      assert artista.documento == "some updated documento"
      assert artista.nombre == "some updated nombre"
      assert artista.fecha_nacimiento == ~D[2023-09-14]
      assert artista.nacionalidad == "some updated nacionalidad"
      assert artista.sexo == "some updated sexo"
    end

    test "update_artista/2 with invalid data returns error changeset" do
      artista = artista_fixture()
      assert {:error, %Ecto.Changeset{}} = Artistas.update_artista(artista, @invalid_attrs)
      assert artista == Artistas.get_artista!(artista.id)
    end

    test "delete_artista/1 deletes the artista" do
      artista = artista_fixture()
      assert {:ok, %Artista{}} = Artistas.delete_artista(artista)
      assert_raise Ecto.NoResultsError, fn -> Artistas.get_artista!(artista.id) end
    end

    test "change_artista/1 returns a artista changeset" do
      artista = artista_fixture()
      assert %Ecto.Changeset{} = Artistas.change_artista(artista)
    end
  end
end
