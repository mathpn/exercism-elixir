defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    discount = discount / 100.0
    (1 - discount) * before_discount
  end

  def monthly_rate(hourly_rate, discount) do
    daily_rate(hourly_rate) * 22 |> apply_discount(discount) |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_discounted_rate = daily_rate(hourly_rate) |> apply_discount(discount)
    budget / daily_discounted_rate |> Float.floor(1)
  end
end
