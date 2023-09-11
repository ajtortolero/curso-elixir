defmodule GameMemory.MemoryUtils do
  def mapa_alphabet do
    vocales = ["a", "e", "i", "o", "u"]
    alfabeto =
      for letra <- String.graphemes("abcdefghijklmnopqrstuvwxyz") do
        case letra in vocales do
          true -> {String.to_atom(letra), {String.upcase(letra), letra, :vocal, :no_encontrada}}
          false -> {String.to_atom(letra), {String.upcase(letra), letra, :consonante, :no_encontrada}}
        end
      end

    Map.new(alfabeto)
  end

  def obtener_vocales(mapa_alphabet, vocales_encontradas) when length(vocales_encontradas) < 3 do
    claves_vocales = Enum.filter(mapa_alphabet, fn {_, v} -> elem(v, 2) == :vocal end) |> Map.keys
    clave_v = Enum.random(claves_vocales)
    valor_v = Map.get(mapa_alphabet, clave_v)
    pareja = {elem(valor_v, 0), elem(valor_v, 1), elem(valor_v, 2), elem(valor_v, 3)}
    vocales = unless Enum.member?(vocales_encontradas, pareja), do: [pareja | vocales_encontradas], else: vocales_encontradas
    obtener_vocales(mapa_alphabet, vocales)
  end

  def obtener_vocales(_, vocales_encontradas), do: vocales_encontradas

  def obtener_consonantes(mapa_alphabet, consonantes_encontradas) when length(consonantes_encontradas) < 3 do
    claves_consonantes = Enum.filter(mapa_alphabet, fn {_, v} -> elem(v, 2) == :consonante end) |> Map.keys
    clave_c = Enum.random(claves_consonantes)
    valor_c = Map.get(mapa_alphabet, clave_c)
    pareja = {elem(valor_c, 0), elem(valor_c, 1), elem(valor_c, 2), elem(valor_c, 3)}
    consonantes = unless Enum.member?(consonantes_encontradas, pareja), do: [pareja | consonantes_encontradas], else: consonantes_encontradas
    obtener_consonantes(mapa_alphabet, consonantes)
  end

  def obtener_consonantes(_, consonantes_encontradas), do: consonantes_encontradas

  def cargar_tablero(letras_seleccionadas) do
    posiciones_pares = 1..12 |> Enum.to_list
    posiciones_revueltas = Enum.shuffle(posiciones_pares)

    Enum.reduce(posiciones_revueltas, %{}, fn posicion, acc ->
      {letra, letras_seleccionadas} = List.pop_at(letras_seleccionadas, 0)
      {{posicion, acc}, letra}
    end)
  end

  def posiciones_originales(posiciones_pares, letras_seleccionadas) do
    Enum.zip(posiciones_pares, letras_seleccionadas) |> Map.new()
  end
end