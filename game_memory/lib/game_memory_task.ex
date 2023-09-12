defmodule GameMemory.MemoryTask do
  import GameMemory.MemoryUtils

  @game_version :"Juego de Memoria V1.0"

  @doc """
   Para ejecutar el juego
  1.- Ubicarnos en la carpeta lib \
  2.- Ejecutar el siguiente comando "elixirc game_memory_utils.ex game_memory_task.ex"  \
  3.- Ejecutar iex \
  4.- En earlang ejecutar GameMemory.MemoryTask.init_game()
  """

  defp selected_letters(map_alphabet)  do
    vocales = get_vowels(map_alphabet, [])
    consonants = get_consonants(map_alphabet, [])
    Enum.concat(vocales, consonants)
  end

  def init_game do
    IO.puts("#{@game_version}, Bienvenido")
    username = IO.gets("Ingrese Nombre: ") |> String.trim
    sel_letters = selected_letters(alphabet_map())
    board_build = board()
    solved = load_board(sel_letters)
    game(board_build,solved, username, 3, 0, 0)
  end

  defp game(board_on, solved_board, player, lifes, acc_v, acc_c) when lifes > 0 and acc_v < 3 and acc_c < 3  do
    IO.puts("Jugador: #{player}")
    IO.puts("Vidas: #{lifes}")
    IO.puts("Vocales:  #{acc_v}")
    IO.puts("Consonantes:  #{acc_c}")
    IO.puts(board_on)

    ing_pair = IO.gets("Ingrese un par x,y: ")
               |> String.trim
               |> String.split(",")
               |> Enum.map(&String.to_integer/1)
               |> List.to_tuple

    {pair1, pair2} = raw_positions(Map.keys(solved_board),Map.values(solved_board))
                     |> Enum.filter(fn {k,_v} -> k ==  elem(ing_pair, 0) or k == elem(ing_pair, 1) end) |> List.to_tuple

    IO.puts(reveal_cards(board_on, pair1, pair2))

    if String.downcase(elem(pair1, 1)) == String.downcase(elem(pair2, 1)) do

      case is_consonant_or_vowel(pair1) do
        {:vocal} ->
          updated_board = reveal_cards(board_on, pair1, pair2)
          game(updated_board, solved_board, player, lifes, acc_v + 1, acc_c)
        {:consonante}  ->
          updated_board = reveal_cards(board_on, pair1, pair2)
          game(updated_board, solved_board, player, lifes, acc_v, acc_c + 1)
      end

    else

      IO.puts("Incorrecto! Intente nuevamente.")
      game(board_on, solved_board, player, lifes - 1, acc_v, acc_c)
    end
  end

  defp game(_, _, _, lifes, acc_v, acc_c) when lifes == 0, do: {:gameover, :finished}

  defp game(_, _, _, _, acc_v, acc_c), do: {:winner}

  defp reveal_cards(board_on, pair1, pair2) do
    p1 = to_string(elem(pair1, 0))
    p2 = to_string(elem(pair2, 0))
    String.replace(board_on, "-"<>p1<>"-", elem(pair1, 1)) |> String.replace("-"<>p2<>"-", elem(pair2,1))

  end
end