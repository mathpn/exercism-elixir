defmodule BirdCount do
  def today([today | _]) do
    today
  end

  def today([]) do
    nil
  end

  def increment_day_count([today | other_days]) do
    today = today + 1
    [today | other_days]
  end

  def increment_day_count([]) do
    [1]
  end

  def has_day_without_birds?([head | _]) when head == 0 do
    true
  end

  def has_day_without_birds?([_ | tail]) do
    has_day_without_birds?(tail)
  end

  def has_day_without_birds?([]) do
    false
  end

  def total([head | tail]) do
    head + total(tail)
  end

  def total([]) do
    0
  end

  def busy_days([head | tail]) when head >= 5 do
    1 + busy_days(tail)
  end

  def busy_days([_ | tail]) do
    0 + busy_days(tail)
  end

  def busy_days([]) do
    0
  end

end
