defmodule AdventOfCode2019.Day1Part2Test do
  use ExUnit.Case

  alias AdventOfCode2019.Day1Part2, as: Subject

  describe "calc_fuel" do
    test "12 mass require 2 fuel" do
      assert 2 == Subject.calc_fuel(12)
    end

    test "14 mass require 2 fuel" do
      assert 2 == Subject.calc_fuel(14)
    end

    test "1969 mass require 654 fuel" do
      assert 966 == Subject.calc_fuel(1969)
    end

    test "100756 mass require 33583 fuel" do
      assert 50_346 == Subject.calc_fuel(100_756)
    end
  end
end
