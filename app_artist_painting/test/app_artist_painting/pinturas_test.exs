defmodule AppArtistPainting.PinturasTest do
  use AppArtistPainting.DataCase

  alias AppArtistPainting.Pinturas

  describe "pinturas" do
    alias AppArtistPainting.Pinturas.Pintura

    import AppArtistPainting.PinturasFixtures

    @invalid_attrs %{titulo: nil, anio_creacion: nil, estilo_pintura: nil}

    test "list_pinturas/0 returns all pinturas" do
      pintura = pintura_fixture()
      assert Pinturas.list_pinturas() == [pintura]
    end

    test "get_pintura!/1 returns the pintura with given id" do
      pintura = pintura_fixture()
      assert Pinturas.get_pintura!(pintura.id) == pintura
    end

    test "create_pintura/1 with valid data creates a pintura" do
      valid_attrs = %{titulo: "some titulo", anio_creacion: 42, estilo_pintura: "some estilo_pintura"}

      assert {:ok, %Pintura{} = pintura} = Pinturas.create_pintura(valid_attrs)
      assert pintura.titulo == "some titulo"
      assert pintura.anio_creacion == 42
      assert pintura.estilo_pintura == "some estilo_pintura"
    end

    test "create_pintura/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pinturas.create_pintura(@invalid_attrs)
    end

    test "update_pintura/2 with valid data updates the pintura" do
      pintura = pintura_fixture()
      update_attrs = %{titulo: "some updated titulo", anio_creacion: 43, estilo_pintura: "some updated estilo_pintura"}

      assert {:ok, %Pintura{} = pintura} = Pinturas.update_pintura(pintura, update_attrs)
      assert pintura.titulo == "some updated titulo"
      assert pintura.anio_creacion == 43
      assert pintura.estilo_pintura == "some updated estilo_pintura"
    end

    test "update_pintura/2 with invalid data returns error changeset" do
      pintura = pintura_fixture()
      assert {:error, %Ecto.Changeset{}} = Pinturas.update_pintura(pintura, @invalid_attrs)
      assert pintura == Pinturas.get_pintura!(pintura.id)
    end

    test "delete_pintura/1 deletes the pintura" do
      pintura = pintura_fixture()
      assert {:ok, %Pintura{}} = Pinturas.delete_pintura(pintura)
      assert_raise Ecto.NoResultsError, fn -> Pinturas.get_pintura!(pintura.id) end
    end

    test "change_pintura/1 returns a pintura changeset" do
      pintura = pintura_fixture()
      assert %Ecto.Changeset{} = Pinturas.change_pintura(pintura)
    end
  end
end
