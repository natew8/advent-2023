defmodule One do
  def get_numbers(input) do
    input
    |> Enum.map(fn s ->
      Regex.scan(~r/\d|oneight|eightwo|fiveight|nineight|sevenine|twone|threeight|eighthree|one|two|three|four|five|six|seven|eight|nine/, s)
      |> List.flatten()
      |> get_first_and_last()
    end)
  end

  defp get_first_and_last(nums) do
    [{hd(nums), 0}, {List.last(nums), 1}]
    |> Enum.map(fn {num, i} -> parse_number(num, i) end)
    |> Enum.join()
    |> String.to_integer()
  end

  defp parse_number(num, i) do
    case num do
      "one" -> 1
      "two" -> 2
      "three" -> 3
      "four" -> 4
      "five" -> 5
      "six" -> 6
      "seven" -> 7
      "eight" -> 8
      "nine" -> 9
      "oneight" -> Enum.at([1,8], i)
      "eightwo" -> Enum.at([8,2], i)
      "fiveight" -> Enum.at([5,8], i)
      "nineight" -> Enum.at([9,8], i)
      "sevenine" -> Enum.at([7,9], i)
      "twone" -> Enum.at([2,1], i)
      "threeight" -> Enum.at([3,8], i)
      "eighthree" -> Enum.at([8,3], i)
      _ -> String.to_integer(num)
    end
  end


end

total = File.read!(Path.join(__DIR__, "input"))
|> String.split("\n", trim: true)
|> One.get_numbers()
|> Enum.sum()

IO.inspect("the total is: #{total}")
