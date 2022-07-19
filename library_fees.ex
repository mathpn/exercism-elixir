defmodule LibraryFees do

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    time = NaiveDateTime.to_time(datetime)
    Time.diff(time, ~T[12:00:00]) < 0
  end

  def return_date(checkout_datetime) do
    before_noon = before_noon?(checkout_datetime)
    checkout_date = NaiveDateTime.to_date(checkout_datetime)
    added_days = if before_noon, do: 28, else: 29
    Date.add(checkout_date, added_days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    diff_days = Date.diff(actual_return_date, planned_return_date)
    max(0, diff_days)
  end

  def monday?(datetime) do
    date = NaiveDateTime.to_date(datetime)
    Date.day_of_week(date) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)
    days_late = checkout_datetime
    |> return_date() |> days_late(return_datetime)
    if monday?(return_datetime) do
      Kernel.floor(rate * days_late / 2)
    else
      rate * days_late
    end
  end

end
