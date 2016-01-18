defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekdays %{
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4,
    saturday: 5,
    sunday: 6
  }

  @day_for_week_start %{
    first: 1,
    second: 8,
    third: 15,
    fourth: 22,
    teenth: 13
  }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    start_date = date_for_week_start(year, month, schedule)
    offset = weekday_for_date(start_date) |> distance_between_weekdays(weekday)
    put_elem(start_date, 2, elem(start_date, 2) + offset)
  end


  defp week_start_day(schedule) do
    @day_for_week_start[schedule]
  end

  defp week_start_day(:last, year, month) do
    :calendar.last_day_of_the_month(year, month) - 6
  end

  defp date_for_week_start(year, month, :last) do
    {year, month, week_start_day(:last, year, month)}
  end

  defp date_for_week_start(year, month, schedule) do
    {year, month, week_start_day(schedule)}
  end

  defp distance_between_weekdays(from, to) when is_atom(to) do
    distance_between_weekdays(from, @weekdays[to])
  end

  defp distance_between_weekdays(from, to) when is_integer(to) and from < to do
    to - from
  end

  defp distance_between_weekdays(from, to) when is_integer(to) and from > to do
    to - from + 7
  end

  defp distance_between_weekdays(from, to) when from == to do
    0
  end

  defp weekday_for_date(date) do
   :calendar.day_of_the_week(date) - 1
  end
end

