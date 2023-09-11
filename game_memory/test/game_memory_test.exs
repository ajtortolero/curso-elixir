defmodule GameMemoryTest do
  use ExUnit.Case
  doctest GameMemory

  test "greets the world" do
    assert GameMemory.hello() == :world
  end
end
