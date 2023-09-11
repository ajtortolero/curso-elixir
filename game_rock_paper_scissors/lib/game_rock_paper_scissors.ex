defmodule GameRockPaperScissors do
  @tipos [:piedra, :papel, :tijera]

  def jugar do
    IO.puts("¡Bienvenido al juego de Piedra, Papel o Tijera!")
    IO.puts("Elige una opción:")
    IO.puts("1. Piedra")
    IO.puts("2. Papel")
    IO.puts("3. Tijera")

    jugador = leer_opcion()
    computadora = elegir_opcion()

    IO.puts("Elegiste: #{to_string(Enum.at(@tipos, jugador - 1))}")
    IO.puts("La computadora eligió: #{to_string(Enum.at(@tipos, computadora - 1))}")

    resultado = determinar_resultado(jugador, computadora)
    IO.puts("Resultado: #{resultado}")
  end

  defp leer_opcion do
    input = IO.gets("Elige una opción (1/2/3):")
    case String.trim(input) do
      "1" -> 1
      "2" -> 2
      "3" -> 3
      _ ->
        IO.puts("Opción no válida. Elige 1, 2 o 3.")
        leer_opcion()
    end
  end

  defp elegir_opcion do
    :rand.seed(:os.timestamp())
    :rand.uniform(3) + 1
  end

  defp determinar_resultado(jugador, computadora) do
    case {jugador, computadora} do
      {1, 3} -> "¡Ganaste! Piedra vence a Tijera."
      {2, 1} -> "¡Ganaste! Papel vence a Piedra."
      {3, 2} -> "¡Ganaste! Tijera vence a Papel."
      {1, 2} -> "¡Perdiste! Papel vence a Piedra."
      {2, 3} -> "¡Perdiste! Tijera vence a Papel."
      {3, 1} -> "¡Perdiste! Piedra vence a Tijera."
      _ -> "Es un empate."
    end
  end
end
