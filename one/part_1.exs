defmodule One do
  def get_numbers(input) do
    input
    |> Enum.map(fn s ->
      nums = Regex.scan(~r/\d/, s) |> List.flatten()
      Enum.join([hd(nums), List.last(nums)]) |> String.to_integer()
    end)
  end
end

File.read!(Path.join(__DIR__, "input"))
|> String.split("\n", trim: true)
|> One.get_numbers()
|> Enum.sum()
|> IO.inspect()
