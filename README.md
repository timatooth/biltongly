# Biltongly

Monitor your biltong drying process with Biltongly.

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

# Distributed fussing

The Golden command to connect to fly.io. But can only call named functions

On Mac:

```elixir
iex --erl '-proto_dist inet6_tcp' --cookie "Fw33jJqCDYtfYpSYX4LcRYl5pTX42azGqy3OMcMOc0Ziw1bPmIuN2w==" --name 'me@fdaa:0:c3b7:a7b:9076:0:a:c02'
```

```elixir
iex --erl '-proto_dist inet6_tcp' --cookie "Fw33jJqCDYtfYpSYX4LcRYl5pTX42azGqy3OMcMOc0Ziw1bPmIuN2w==" --name 'meagain@fdaa:0:c3b7:a7b:9076:0:a:c02' --remsh 'nerves@fdaa:0:c3b7:a7b:9076:0:a:902'
```

On Nerves:

```elixir
System.cmd("epmd", ["-daemon"])
Node.start(:"nerves@fdaa:0:c3b7:a7b:9076:0:a:902")
Node.set_cookie(:"Fw33jJqCDYtfYpSYX4LcRYl5pTX42azGqy3OMcMOc0Ziw1bPmIuN2w==")
```

### on fly node

```
fly ssh console --pty -C "/app/bin/biltongly remote"
```
