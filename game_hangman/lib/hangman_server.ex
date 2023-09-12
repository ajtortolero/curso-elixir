defmodule GameHangman.HangmanServer do
  import GameHangman.HangmanUtils
  use GenServer

  @game_version :"Hangman V4.5"

  @doc """
   Para ejecutar el juego
  1.- Ubicarnos en la carpeta lib \
  2.- Ejecutar el siguiente comando "elixirc hangman_utils.ex hangman_server.ex"  \
  3.- Ejecutar iex \
  4.- En earlang ejecutar GameHangman.HangmanServer.init_game(3)
  """

  def init_game(clue) when clue <= 3 do
    {:ok, pid} = start_server(clue)
    {selW,w_game} = word_to_play()
    game(w_game, selW, 0, 0, victim(), pid)
  end

  def init_game(clue) when is_integer(clue) and clue <= 0 do
    IO.puts("#{@game_version}, La cantidad de pistas no puede ser menor o igual a 0.")
  end

  def init_game(clue) when is_integer(clue) and clue > 3 do
    IO.puts("#{@game_version}, La cantidad de pistas no puede ser mayor que 3.")
  end

  defp game(word_game, selW, oport, ptos, drawing, pid) when word_game != selW and oport < 6 do
    IO.puts("#{@game_version}")
    IO.puts(word_game)
    IO.puts(drawing)
    IO.puts("#{@game_version}, Puntos: #{ptos}")

    ing_l = IO.gets("#{@game_version}, Ingrese una letra o solicita una pista ([P]): ") |> String.trim

    ptos_x_ing = case ing_l do
      "[P]" -> 0
      _ -> Map.get(abc_points(), String.downcase(ing_l))
    end

    {up_word_game, oport, ptos, drawing} = case {ing_l, String.contains?(selW, ing_l)} do
      {ing_l, true} -> {update_word(word_game, ing_l, selW), oport, ptos+ptos_x_ing, drawing}
      {"[P]", false} -> {give_clue(word_game, selW, pid), oport , ptos, drawing}
      {_, false    } -> {word_game, oport + 1, ptos, update_victim(oport+1, drawing) }
    end

    game(up_word_game, selW, oport, ptos, drawing, pid)

  end

  defp game(word_game, selW, _ , ptos, _, pid) when word_game == selW do
    result = "#{@game_version}, Felicidades tu puntaje fue de: #{ptos}"
    stop_server(result, pid)
    {:guessed, selW, ptos}
  end

  defp game(_, _, oport, ptos, _ , pid) when oport == 6 do
    result = "#{@game_version}, No has ganado, tu puntaje fue de: #{ptos}, Suerte para la próxima."
    stop_server(result, pid)
    {:gameover, ptos}
  end

  def start_server(clue) do
    IO.puts("#{@game_version}, Iniciando el servidor de pistas")
    GenServer.start_link(__MODULE__, %{:clues => clue})
  end

  def init(%{clues: clue}) do
    IO.puts("#{@game_version}, Juego iniciado con #{clue} pistas")
    {:ok, %{clues: clue}}
  end

  def handle_call({word_game, selW}, _from, status) do
    %{clues: clue} = status

    {clue_n, word_up} = case clue > 0 do
      true  ->   IO.puts("#{@game_version}, Quedan #{clue-1} pistas")
                 {clue - 1, update_word_clue(word_game, selW)}
      false ->   IO.puts("#{@game_version}, Usted no tiene pistas disponibles.")
                 {clue, word_game}
    end

    status_new = %{clues: clue_n}
    {:reply, word_up, status_new }
  end

  defp give_clue(word_game, selW, pid) do
    GenServer.call(pid, {word_game, selW})
  end

  defp stop_server(result, pid) do
    IO.puts("#{@game_version}, Resultado #{result}")
    IO.puts("#{@game_version}, Fin del juego. Resultado #{result}")
    result_stop = GenServer.stop(pid)
    IO.inspect(result_stop, label: "#{@game_version}, El servidor de pistas fue detenido.")
  end
end
