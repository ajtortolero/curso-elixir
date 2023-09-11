defmodule GameMemory.MemoryTask do
  import GameMemory.MemoryUtils

  defp letras_seleccionadas(mapa_alphabet) do
    vocales = obtener_vocales(mapa_alphabet, [])
    consonantes = obtener_consonantes(mapa_alphabet, [])
    Enum.concat(vocales, consonantes)
  end

  def init_game do
    letras_seleccionadas = letras_seleccionadas(mapa_alphabet())
    resuelto = cargar_tablero(letras_seleccionadas)
    juego(resuelto, resuelto, "Jugador", 3, 0, 0)
  end

  defp juego(tablero_actual, tablero_resuelto, jugador, vidas, acc_v, acc_c) when vidas > 0 and acc_v < 3 and acc_c < 3 do
    IO.puts("Jugador: #{jugador}")
    IO.puts("Vidas: #{vidas}")
    IO.puts("Vocales encontradas: #{acc_v}")
    IO.puts("Consonantes encontradas: #{acc_c}")
    IO.puts(tablero_actual)

    pareja_ingresada = IO.gets("Ingresa una pareja x,y: ")
                       |> String.trim
                       |> String.split(",")
                       |> Enum.map(&String.to_integer/1)
                       |> List.to_tuple

    pareja_ingresada_invertida = pareja_ingresada |> Tuple.to_list |> Enum.reverse |> List.to_tuple

    {pareja1, pareja2} = posiciones_originales(Map.keys(tablero_resuelto), Map.values(tablero_resuelto))
                         |> Enum.filter(fn {k, _v} -> k == elem(pareja_ingresada, 0) or k == elem(pareja_ingresada, 1) end)
                         |> List.to_tuple

    IO.puts(revelar_cartas(tablero_actual, pareja1, pareja2))

    case {pareja1, pareja2} do
      {{_, _, :vocal, :no_encontrada}, {_, _, :vocal, :no_encontrada}} ->
        IO.puts("¡Pareja de vocales correcta!")
        tablero_actualizado = revelar_cartas(tablero_actual, pareja1, pareja2)
        juego(tablero_actualizado, tablero_resuelto, jugador, vidas, acc_v + 1, acc_c)

      {{_, _, :consonante, :no_encontrada}, {_, _, :consonante, :no_encontrada}} ->
        IO.puts("¡Pareja de consonantes correcta!")
        tablero_actualizado = revelar_cartas(tablero_actual, pareja1, pareja2)
        juego(tablero_actualizado, tablero_resuelto, jugador, vidas, acc_v, acc_c + 1)

      _ ->
        IO.puts("¡Pareja incorrecta!")
        juego(tablero_actual, tablero_resuelto, jugador, vidas - 1, acc_v, acc_c)
    end
  end

  defp juego(_, _, _, vidas, _, _) when vidas == 0, do: {:fin_de_juego, :terminado}

  defp juego(_, _, _, _, acc_v, acc_c) when acc_v + acc_c == 6, do: {:ganador}

  defp juego(_, _, _, _, _, _), do: {:continuar}

  defp revelar_cartas(tablero_actual, pareja1, pareja2) do
    p1 = to_string(elem(pareja1, 0))
    p2 = to_string(elem(pareja2, 0))
    String.replace(tablero_actual, "-" <> p1 <> "-", elem(pareja1, 1))
    |> String.replace("-" <> p2 <> "-", elem(pareja2, 1))
  end
end