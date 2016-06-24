defmodule PingTest do
  use ExUnit.Case

  test "it responds to a ping with a ping" do
    ping = spawn_link(Ping, :start, [])
    Process.send ping, {:pong, self}, [] # drop message into ping process's mailbox
    assert_receive {:ping, ^ping}
  end

  test "it responds to two pings with two pings" do
    ping = spawn_link(Ping, :start, [])
    Process.send ping, {:pong, self}, [] # drop message into ping process's mailbox
    assert_receive {:ping, ^ping}
    ping2 = spawn_link(Ping, :start, [])
    assert_receive {:ping, ^ping2}
  end
end
