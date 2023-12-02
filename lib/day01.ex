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

defmodule Day01.Part2 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&extract_numbers/1)
    |> Enum.sum()
  end

  defp extract_numbers(line) do
    line = word_to_integer(line)
    numbers =
      line
      |> String.graphemes()
      |> Enum.map(&parse_integer/1)
      |> Enum.reject(&is_nil/1)

      first = List.first(numbers)
      last = List.last(numbers)
      first * 10 + last
  end

  defp word_to_integer(word) do
    IO.puts(word)

    number_words_to_digits = %{
      "one" => "1", "two" => "2", "three" => "3", "four" => "4",
      "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9"
    }

    regex_pattern = Enum.join(Map.keys(number_words_to_digits), "|")
    regex = ~r/#{regex_pattern}/

    digit_sequence = Regex.scan(regex, word)
    |> Enum.map(fn [match] -> number_words_to_digits[match] end)
    |> Enum.join("")

    IO.puts(digit_sequence)

    digit_sequence
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
    #IO.puts("Part 1: #{Day01.Part1.solve(input)}")
    IO.puts("Part 2: #{Day01.Part2.solve(input)}")
  end
end
