defmodule RPNCalculator do

  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      e in ArgumentError -> {:error, e.message}
    end
  end

end


defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
      end
    end
  end

  def divide(stack) do
    case stack do
      [] -> raise StackUnderflowError, "when dividing"
      [_] -> raise StackUnderflowError, "when dividing"
      [0 | _] -> raise DivisionByZeroError
      [denom, nume] -> nume / denom
    end
  end
end


defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end
  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end
  def reliability_check(calculator, inputs) do
    old_flag = Process.flag(:trap_exit, true)
    results = inputs
    |> Enum.map(&(start_reliability_check(calculator, &1)))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    Process.flag(:trap_exit, old_flag)
    results
  end
  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input -> Task.async(fn -> calculator.(input) end) end)
    |> Enum.map(&(Task.await(&1, 100)))
  end
end
