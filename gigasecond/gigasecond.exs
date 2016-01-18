defmodule Gigasecond do
	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  @seconds_per_day 86400
  @gigasecond 1_000_000_000

	def from(datetime = {{_year, _month, _day}, {_hour, _minute, _second}}) do
    datetime_to_gregorian_seconds(datetime) + @gigasecond |> :calendar.gregorian_seconds_to_datetime
  end

  defp datetime_to_gregorian_seconds(datetime) do
    :calendar.datetime_to_gregorian_seconds(datetime)
  end
end
