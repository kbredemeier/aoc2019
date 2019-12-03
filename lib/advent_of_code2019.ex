defmodule AdventOfCode2019 do
  @moduledoc """
  This project contains the solutions for the Advent of Code challenges from
  2019.
  """

  def benchmark(fun, unit \\ :millisecond) do
    start_time = System.monotonic_time(unit)
    result = fun.()
    end_time = System.monotonic_time(unit)
    IO.puts("Took #{end_time - start_time} #{unit}s")
    result
  end
end
