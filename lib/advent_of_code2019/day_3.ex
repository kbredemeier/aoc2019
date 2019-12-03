defmodule AdventOfCode2019.Day3 do
  def part_1 do
    [cab1_directions, cab2_directions, _] = read_input_file()

    cab1_coordinates =
      [{0, 0}] |> calculate_path(cab1_directions) |> MapSet.new()

    cab2_coordinates =
      [{0, 0}] |> calculate_path(cab2_directions) |> MapSet.new()

    intersections = MapSet.intersection(cab1_coordinates, cab2_coordinates)

    intersections
    |> Enum.map(&calc_point_distance({0, 0}, &1))
    |> Enum.sort()
    |> Enum.at(1)
  end

  def part_2 do
    [cab1_directions, cab2_directions, _] = read_input_file()

    cab1_coordinates =
      [{0, 0}] |> calculate_path(cab1_directions) |> Enum.reverse()

    cab2_coordinates =
      [{0, 0}] |> calculate_path(cab2_directions) |> Enum.reverse()

    intersections =
      MapSet.intersection(
        MapSet.new(cab1_coordinates),
        MapSet.new(cab2_coordinates)
      )

    intersections
    |> Enum.map(fn coordinates ->
      cab1_index = Enum.find_index(cab1_coordinates, &(&1 == coordinates))
      cab2_index = Enum.find_index(cab2_coordinates, &(&1 == coordinates))
      cab1_index + cab2_index
    end)
    |> Enum.sort()
    |> Enum.at(1)
  end

  def calculate_path(path, []), do: path

  def calculate_path(path, [next_instruction | tail]) do
    line = calc_step_coordinates(next_instruction, path)
    calculate_path(line, tail)
  end

  def calc_step_coordinates({_, 0}, coordinates), do: coordinates

  def calc_step_coordinates(
        {dir, dist} = direction,
        [last_coordinates | _] = path
      ) do
    step = calc_next_coordinates(last_coordinates, {dir, 1})
    calc_step_coordinates({dir, dist - 1}, [step | path])
  end

  def calc_next_coordinates({x, y}, {:up, dist}), do: {x, y + dist}
  def calc_next_coordinates({x, y}, {:down, dist}), do: {x, y - dist}
  def calc_next_coordinates({x, y}, {:right, dist}), do: {x + dist, y}
  def calc_next_coordinates({x, y}, {:left, dist}), do: {x - dist, y}

  def calc_point_distance({start_x, start_y}, {end_x, end_y}) do
    calc_axis_distance(start_x, end_x) + calc_axis_distance(start_y, end_y)
  end

  def calc_axis_distance(n, n), do: 0
  def calc_axis_distance(x, y) when x > y, do: x - y
  def calc_axis_distance(x, y) when y > x, do: y - x

  defp read_input_file do
    :aoc2019
    |> :code.priv_dir()
    |> Path.join("day_3/input.txt")
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn directions ->
      directions
      |> Enum.reject(fn
        "" -> true
        _ -> false
      end)
      |> Enum.map(&parse_instruction/1)
    end)
  end

  def parse_instruction("U" <> dist), do: build_directions_tuple(:up, dist)
  def parse_instruction("D" <> dist), do: build_directions_tuple(:down, dist)
  def parse_instruction("L" <> dist), do: build_directions_tuple(:left, dist)
  def parse_instruction("R" <> dist), do: build_directions_tuple(:right, dist)

  defp build_directions_tuple(dir, dist_str) do
    {dist, _} = Integer.parse(dist_str)
    {dir, dist}
  end
end
