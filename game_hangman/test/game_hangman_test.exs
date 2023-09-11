defmodule GameHangmanTest do
  use ExUnit.Case
  doctest GameHangman

  test "greets the world" do
    assert GameHangman.hello() == :world
  end
end
