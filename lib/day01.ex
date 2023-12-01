defmodule Day01.Part1 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&extract_numbers/1)
    |> Enum.sum()
  end

  defp extract_numbers(line) do
    numbers =
      line
      |> String.graphemes()
      |> Enum.map(&parse_integer/1)
      |> Enum.reject(&is_nil/1)

      #[first] = numbers
      first = List.first(numbers)
      last = List.last(numbers)
      first * 10 + last
  end

  defp parse_integer(char) do
    try do
      String.to_integer(char)
    rescue
      ArgumentError -> nil
    end
  end
end


defmodule Mix.Tasks.Day01 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day1.txt")

    IO.puts("Part 1: #{Day01.Part1.solve(input)}")
  end
end
