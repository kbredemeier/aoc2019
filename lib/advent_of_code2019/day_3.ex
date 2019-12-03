defmodule AdventOfCode2019.Day3 do
  def part_1 do
    [wire1_directions, wire2_directions] = read_input_file()

    # Builds up a list with all coordinates that a wire crosses in reverse order
    # (meaning the first element is where the wire ends)
    wire1_coordinates =
      [{0, 0}] |> calculate_path(wire1_directions) |> MapSet.new()

    wire2_coordinates =
      [{0, 0}] |> calculate_path(wire2_directions) |> MapSet.new()

    intersections = MapSet.intersection(wire1_coordinates, wire2_coordinates)

    # Gets the manhattan distance from the second largest element. The first
    # element is the distance at {0, 0} which is 0.
    intersections
    |> Enum.map(&calc_manhattan_distance({0, 0}, &1))
    |> Enum.sort()
    |> Enum.at(1)
  end

  def part_2 do
    [wire1_directions, wire2_directions] = read_input_file()

    # To get the actual distance of each coordinate where the wires intersect
    # the list must be reversed. That way the index is also the distance.
    wire1_coordinates =
      [{0, 0}] |> calculate_path(wire1_directions) |> Enum.reverse()

    wire2_coordinates =
      [{0, 0}] |> calculate_path(wire2_directions) |> Enum.reverse()

    intersections =
      MapSet.intersection(
        MapSet.new(wire1_coordinates),
        MapSet.new(wire2_coordinates)
      )

    # Gets the distance for each wire at the intersections by finding the index
    # in each wire's list of coordinates. Again, the first element is the
    # distance at {0, 0}.
    intersections
    |> Enum.map(fn coordinates ->
      wire1_distance = Enum.find_index(wire1_coordinates, &(&1 == coordinates))
      wire2_distance = Enum.find_index(wire2_coordinates, &(&1 == coordinates))
      wire1_distance + wire2_distance
    end)
    |> Enum.sort()
    |> Enum.at(1)
  end

  def calculate_path(path, []), do: path

  def calculate_path(path, [next_instruction | tail]) do
    line = calc_instruction_path(next_instruction, path)
    calculate_path(line, tail)
  end

  def calc_instruction_path({_, 0}, coordinates), do: coordinates

  def calc_instruction_path(
        {dir, dist},
        [last_coordinates | _] = path
      ) do
    step = calc_next_coordinates(last_coordinates, {dir, 1})
    calc_instruction_path({dir, dist - 1}, [step | path])
  end

  def calc_next_coordinates({x, y}, {:up, dist}), do: {x, y + dist}
  def calc_next_coordinates({x, y}, {:down, dist}), do: {x, y - dist}
  def calc_next_coordinates({x, y}, {:right, dist}), do: {x + dist, y}
  def calc_next_coordinates({x, y}, {:left, dist}), do: {x - dist, y}

  def calc_manhattan_distance({start_x, start_y}, {end_x, end_y}) do
    calc_axis_distance(start_x, end_x) + calc_axis_distance(start_y, end_y)
  end

  def calc_axis_distance(n, n), do: 0
  def calc_axis_distance(x, y) when x > y, do: x - y
  def calc_axis_distance(x, y) when y > x, do: y - x

  def parse_instruction("U" <> dist), do: {:up, String.to_integer(dist)}
  def parse_instruction("D" <> dist), do: {:down, String.to_integer(dist)}
  def parse_instruction("L" <> dist), do: {:left, String.to_integer(dist)}
  def parse_instruction("R" <> dist), do: {:right, String.to_integer(dist)}

  defp read_input_file do
    :aoc2019
    |> :code.priv_dir()
    |> Path.join("day_3/input.txt")
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn directions ->
      directions
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&parse_instruction/1)
    end)
  end
end
