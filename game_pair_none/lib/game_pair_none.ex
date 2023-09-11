defmodule GamePairNone do

  @doc """
   Para ejecutar el juego
  1.- Ubicarnos en la carpeta lib \
  2.- Ejecutar el siguiente comando "elixirc game_pair_none.ex"  \
  3.- Ejecutar iex \
  4.- En earlang ejecutar GamePairNone.jugar()
  """

  def jugar do
    IO.puts("¡Bienvenido al juego de Pares o Nones!")
    IO.puts("Por favor, elige tu jugada (pares/nones): ")

    jugada_jugador = String.downcase(IO.gets(""))
    jugada_jugador = String.replace(jugada_jugador, ~r/\n/, "")

    case jugada_jugador do
      "pares" ->
        IO.puts("Has elegido 'pares'.")
      "nones" ->
        IO.puts("Has elegido 'nones'.")
      _ ->
        IO.puts("Jugada inválida. Debes elegir 'pares' o 'nones'.")
        jugar()
    end

    # Generar un número aleatorio entre 1 y 10 para la suma de objetos.
    suma_objetos = :rand.uniform(10)
    IO.puts("La suma de objetos es #{suma_objetos}.")

    # Determinar si la suma es par o impar.
    resultado = if rem(suma_objetos, 2) == 0, do: "pares", else: "nones"

    IO.puts("El resultado es #{resultado}.")

    # Determinar el ganador.
    if resultado == jugada_jugador do
      IO.puts("¡Has ganado!")
    else
      IO.puts("¡El oponente gana!")
    end
  end
end
