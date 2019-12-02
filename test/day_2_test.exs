defmodule AdventOfCode2019.Day2Test do
  use ExUnit.Case

  alias AdventOfCode2019.Day2, as: Subject

  test "#1" do
    assert [2, 0, 0, 0, 99] == Subject.run_program([1, 0, 0, 0, 99])
  end

  test "#2" do
    assert [2, 3, 0, 6, 99] == Subject.run_program([2, 3, 0, 3, 99])
  end

  test "#3" do
    assert [2, 4, 4, 5, 99, 9801] == Subject.run_program([2, 4, 4, 5, 99, 0])
  end

  test "#4" do
    assert [30, 1, 1, 4, 2, 5, 6, 0, 99] ==
             Subject.run_program([1, 1, 1, 4, 99, 5, 6, 0, 99])
  end

  test "combinations/1" do
    assert [[0, 0]] == Subject.combinations([0, 0], 2)
    assert [[1, 1]] == Subject.combinations([1, 1], 2)
    assert [[0, 1], [1, 0]] == Subject.combinations([0, 1], 2)

    assert [[0, 1], [0, 2], [1, 2], [2, 1], [1, 0], [2, 0]] ==
             Subject.combinations([0, 1, 2], 2)
  end
end
