defmodule Day03.Part1 do
  def solve(input) do
    lines = String.split(input, "\n", trim: true)

    lines
    |> Enum.map(&get_parts/1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end

  def get_parts(line) do
    Regex.scan(~r/\d+/, line)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end
end

defmodule Mix.Tasks.Day03 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day3test.txt")
    IO.puts("Part 1: #{Day03.Part1.solve(input)}")
  end
end
