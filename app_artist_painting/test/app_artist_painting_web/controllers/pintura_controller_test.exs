defmodule AppArtistPaintingWeb.PinturaControllerTest do
  use AppArtistPaintingWeb.ConnCase

  import AppArtistPainting.PinturasFixtures

  alias AppArtistPainting.Pinturas.Pintura

  @create_attrs %{
    titulo: "some titulo",
    anio_creacion: 42,
    estilo_pintura: "some estilo_pintura"
  }
  @update_attrs %{
    titulo: "some updated titulo",
    anio_creacion: 43,
    estilo_pintura: "some updated estilo_pintura"
  }
  @invalid_attrs %{titulo: nil, anio_creacion: nil, estilo_pintura: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pinturas", %{conn: conn} do
      conn = get(conn, ~p"/api/pinturas")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pintura" do
    test "renders pintura when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/pinturas", pintura: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/pinturas/#{id}")

      assert %{
               "id" => ^id,
               "anio_creacion" => 42,
               "estilo_pintura" => "some estilo_pintura",
               "titulo" => "some titulo"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/pinturas", pintura: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pintura" do
    setup [:create_pintura]

    test "renders pintura when data is valid", %{conn: conn, pintura: %Pintura{id: id} = pintura} do
      conn = put(conn, ~p"/api/pinturas/#{pintura}", pintura: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/pinturas/#{id}")

      assert %{
               "id" => ^id,
               "anio_creacion" => 43,
               "estilo_pintura" => "some updated estilo_pintura",
               "titulo" => "some updated titulo"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pintura: pintura} do
      conn = put(conn, ~p"/api/pinturas/#{pintura}", pintura: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pintura" do
    setup [:create_pintura]

    test "deletes chosen pintura", %{conn: conn, pintura: pintura} do
      conn = delete(conn, ~p"/api/pinturas/#{pintura}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/pinturas/#{pintura}")
      end
    end
  end

  defp create_pintura(_) do
    pintura = pintura_fixture()
    %{pintura: pintura}
  end
end
