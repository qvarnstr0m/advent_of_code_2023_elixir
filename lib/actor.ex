defmodule Actor do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(Actor, nil, opts)
  end

  @impl GenServer
  def init(_) do
    state = %{
        data: %{},
        operations: 0
    }
    {:ok, state}
  end

  def set(pid, key, value) do
    GenServer.call(pid, {:set, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def unset(pid, key) do
    GenServer.call(pid, {:unset, key})
  end

  @impl GenServer
  def handle_call({:set, key, value}, _from, state) do
    data = Map.put(state.data, key, value)
    {:reply, :ok, %{ state | data: data, operations: state.operations + 1}}
  end

  def handle_call({:get, key}, _from, state) do
    value = Map.get(state.data, key)
    {:reply, value, %{state | operations: state.operations + 1}}
  end

  def handle_call({:unset, key}, _from, state) do
    data = Map.delete(state.data, key)
    {:reply, :ok, %{state | data: data, operations: state.operations + 1}}
  end
end
