defmodule AdventOfCode2019.Day2 do
  def run_part_1 do
    read_input_file()
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> run_program(0)
    |> hd
  end

  def run_part_2 do
    input = read_input_file()

    combis =
      0..99
      |> Enum.into([])
      |> combinations(2)

    [noun, verb] =
      Enum.find(combis, fn [noun, verb] ->
        19_690_720 ==
          input
          |> List.replace_at(1, noun)
          |> List.replace_at(2, verb)
          |> run_program(0)
          |> hd
      end)

    100 * noun + verb
  end

  def combinations(list, num)
  def combinations(_list, 0), do: [[]]
  def combinations(list = [], _num), do: list

  def combinations([head | tail], num) do
    result =
      Enum.map(combinations(tail, num - 1), &[head | &1]) ++
        combinations(tail, num)

    Enum.uniq(result ++ Enum.map(result, &Enum.reverse/1))
  end

  def run_program(program, chunk_index \\ 0) do
    program
    |> Enum.chunk_every(4)
    |> Enum.at(chunk_index)
    |> calc_output(program)
    |> case do
      {:halt, new_program} -> new_program
      {:cont, new_program} -> run_program(new_program, chunk_index + 1)
    end
  end

  defp calc_output([1, left_index, right_index, output_index], program) do
    value = Enum.at(program, left_index) + Enum.at(program, right_index)
    {:cont, List.replace_at(program, output_index, value)}
  end

  defp calc_output([2, left_index, right_index, output_index], program) do
    value = Enum.at(program, left_index) * Enum.at(program, right_index)
    {:cont, List.replace_at(program, output_index, value)}
  end

  defp calc_output([99, _, _, _], program), do: {:halt, program}
  defp calc_output([99, _, _], program), do: {:halt, program}
  defp calc_output([99, _], program), do: {:halt, program}
  defp calc_output([99], program), do: {:halt, program}

  defp read_input_file do
    :aoc2019
    |> :code.priv_dir()
    |> Path.join("day_2/input.txt")
    |> File.read!()
    |> String.split(",")
    |> Enum.map(fn raw_int ->
      {int, _} = Integer.parse(raw_int)
      int
    end)
  end
end
