defmodule AdventOfCode2019.Day1Part2 do
  def calc_required_fuel do
    {:ok, pid} = Agent.start(fn -> 0 end)

    :aoc2019
    |> :code.priv_dir()
    |> Path.join("day_1/input.txt")
    |> File.stream!()
    |> Stream.each(fn line ->
      {mass, _} = Integer.parse(line)

      Agent.update(pid, fn fuel_sum ->
        fuel_sum + calc_fuel(mass)
      end)
    end)
    |> Stream.run()

    fuel_sum = Agent.get(pid, fn fuel_sum -> fuel_sum end)
    Agent.stop(pid, :normal)
    fuel_sum
  end

  def calc_fuel(mass) do
    case do_calc_mass(mass) do
      fuel when fuel <= 0 -> 0
      fuel -> fuel + calc_fuel(fuel)
    end
  end

  defp do_calc_mass(mass), do: trunc(mass / 3) - 2
end
