defmodule Day04.Part1 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    parts = String.split(line, ":")

    index_part = List.first(parts)
    number_part = List.last(parts)

    index_string = String.trim_leading(index_part, "Card ")
    index = String.to_integer(index_string)

    split_number_part = String.split(number_part, "|")

    winning_number_part = List.first(split_number_part)
    dealt_number_part = List.last(split_number_part)

    IO.inspect(index)
    IO.inspect(winning_number_part)
    IO.inspect(dealt_number_part)
  end
  end


defmodule Mix.Tasks.Day04 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day4test.txt")
    IO.puts("Part 1: #{Day04.Part1.solve(input)}")
  end
end
