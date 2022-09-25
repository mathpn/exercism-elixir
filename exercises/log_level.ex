defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      legacy? and level in [0, 5] -> :unknown
      level == 0 -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    log_label = to_label(level, legacy?)
    cond do
      log_label in [:error, :fatal] -> :ops
      legacy? and log_label == :unknown -> :dev1
      log_label == :unknown -> :dev2
      true -> false
    end
  end
end
