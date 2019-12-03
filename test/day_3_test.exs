defmodule AdventOfCode2019.Day3Test do
  use ExUnit.Case

  alias AdventOfCode2019.Day3, as: Subject

  test "parse_instruction/1" do
    assert {:up, 10} = Subject.parse_instruction("U10")
    assert {:down, 10} = Subject.parse_instruction("D10")
    assert {:left, 10} = Subject.parse_instruction("U10")
    assert {:right, 10} = Subject.parse_instruction("U10")
  end

  test "calc_next_coordinates/2" do
    assert {0, 0} = Subject.calc_next_coordinates({0, 0}, {:up, 0})
    assert {0, 0} = Subject.calc_next_coordinates({0, 0}, {:down, 0})
    assert {0, 0} = Subject.calc_next_coordinates({0, 0}, {:left, 0})
    assert {0, 0} = Subject.calc_next_coordinates({0, 0}, {:right, 0})

    assert {0, 1} = Subject.calc_next_coordinates({0, 0}, {:up, 1})
    assert {0, -1} = Subject.calc_next_coordinates({0, 0}, {:down, 1})
    assert {-1, 0} = Subject.calc_next_coordinates({0, 0}, {:left, 1})
    assert {1, 0} = Subject.calc_next_coordinates({0, 0}, {:right, 1})
  end

  test "calc_step_coordinats/2" do
    assert [{0, 2}, {0, 1}, {0, 0}] =
             Subject.calc_step_coordinates({:up, 2}, [{0, 0}])

    assert [{0, 2}, {0, 1}, {0, 0}, {1, 0}] =
             Subject.calc_step_coordinates({:up, 2}, [{0, 0}, {1, 0}])

    assert [{1, 2}, {1, 1}, {1, 0}, {0, 0}] =
             Subject.calc_step_coordinates({:up, 2}, [{1, 0}, {0, 0}])
  end

  test "calculate_path/2" do
    assert [{0, 2}, {0, 1}, {0, 0}] =
             Subject.calculate_path([{0, 0}], [{:up, 2}])

    assert [{1, 2}, {1, 1}, {1, 0}, {0, 0}] =
             Subject.calculate_path([{1, 0}, {0, 0}], [{:up, 2}])

    assert [{-2, 2}, {-1, 2}, {0, 2}, {0, 1}, {0, 0}] =
             Subject.calculate_path([{0, 0}], [{:up, 2}, {:left, 2}])
  end

  test "calc_point_distance/2" do
    assert 0 == Subject.calc_point_distance({0, 0}, {0, 0})
    assert 1 == Subject.calc_point_distance({0, 0}, {1, 0})
    assert 1 == Subject.calc_point_distance({0, 0}, {0, 1})
    assert 1 == Subject.calc_point_distance({1, 0}, {0, 0})
    assert 1 == Subject.calc_point_distance({0, 1}, {0, 0})
    assert 2 == Subject.calc_point_distance({0, 0}, {1, 1})
  end

  test "calc_axis_distance/2" do
    assert 0 == Subject.calc_axis_distance(0, 0)
    assert 1 == Subject.calc_axis_distance(1, 0)
    assert 1 == Subject.calc_axis_distance(0, 1)
  end
end
