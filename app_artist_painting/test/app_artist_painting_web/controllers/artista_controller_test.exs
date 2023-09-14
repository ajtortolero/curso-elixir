defmodule AppArtistPaintingWeb.ArtistaControllerTest do
  use AppArtistPaintingWeb.ConnCase

  import AppArtistPainting.ArtistasFixtures

  alias AppArtistPainting.Artistas.Artista

  @create_attrs %{
    documento: "some documento",
    nombre: "some nombre",
    fecha_nacimiento: ~D[2023-09-13],
    nacionalidad: "some nacionalidad",
    sexo: "some sexo"
  }
  @update_attrs %{
    documento: "some updated documento",
    nombre: "some updated nombre",
    fecha_nacimiento: ~D[2023-09-14],
    nacionalidad: "some updated nacionalidad",
    sexo: "some updated sexo"
  }
  @invalid_attrs %{documento: nil, nombre: nil, fecha_nacimiento: nil, nacionalidad: nil, sexo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all artistas", %{conn: conn} do
      conn = get(conn, ~p"/api/artistas")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create artista" do
    test "renders artista when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/artistas", artista: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/artistas/#{id}")

      assert %{
               "id" => ^id,
               "documento" => "some documento",
               "fecha_nacimiento" => "2023-09-13",
               "nacionalidad" => "some nacionalidad",
               "nombre" => "some nombre",
               "sexo" => "some sexo"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/artistas", artista: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update artista" do
    setup [:create_artista]

    test "renders artista when data is valid", %{conn: conn, artista: %Artista{id: id} = artista} do
      conn = put(conn, ~p"/api/artistas/#{artista}", artista: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/artistas/#{id}")

      assert %{
               "id" => ^id,
               "documento" => "some updated documento",
               "fecha_nacimiento" => "2023-09-14",
               "nacionalidad" => "some updated nacionalidad",
               "nombre" => "some updated nombre",
               "sexo" => "some updated sexo"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, artista: artista} do
      conn = put(conn, ~p"/api/artistas/#{artista}", artista: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete artista" do
    setup [:create_artista]

    test "deletes chosen artista", %{conn: conn, artista: artista} do
      conn = delete(conn, ~p"/api/artistas/#{artista}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/artistas/#{artista}")
      end
    end
  end

  defp create_artista(_) do
    artista = artista_fixture()
    %{artista: artista}
  end
end
