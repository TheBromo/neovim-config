# Neovim configuration

Uses Neovim's built-in `vim.pack` plugin manager. Python debugging uses `nvim-dap-python` and `debugpy`, with `nvim-dap-ui`, `nvim-nio`, and the Python Tree-sitter parser. Go debugging remains enabled.

## Debug the full ChipMind app through Make

Start Neovim inside Herdr. The launcher requires `herdr` on PATH and the Herdr workspace environment; it does not fall back to a Neovim terminal.

F5 starts `make run USE_VITE=1 DEBUG_BACKEND=1` in a dedicated Herdr tab in the current workspace. Make prepares the sandbox and EDA services, starts the backend under debugpy, and waits for Neovim to attach. Make then starts Vite and opens the authenticated browser using the existing bootstrap-token flow. Keep your normal authentication settings; you do not need to disable session tokens or copy a token manually.

1. In your usual development environment, prepare the build when needed:
   ```sh
   cd ~/Development/chipmind
   make build
   ```
   The development dependencies include debugpy. F5 does not run `make build` for you.
2. Stop any previous app using the same ports. Open a **new Neovim process inside Herdr**:
   ```sh
   nvim openhands/server/routes/health.py
   ```
3. Place the cursor on `return {'status': 'ok'}` in `alive()` and press **Space b b** to set a breakpoint.
4. Press **F5**, choose **ChipMind: Make run + debug**, and watch the ChipMind Herdr tab. Neovim attaches automatically when debugpy is ready. First-time sandbox preparation can take longer; setup has a ten-minute timeout until debugpy is ready.
5. Use the automatically opened browser to reproduce your application action. To hit the example breakpoint, request `http://127.0.0.1:3000/alive` in another tab.
6. Inspect Scopes, Watches, and Stacks. Press **Space D e** over an expression (or visual selection) to evaluate it, or **Space D r** for the REPL.
7. Press **F2** to step over, **F1** to step into, **F3** to step out, and **F5** to continue. Requests wait while paused.
8. Press **Space D t** to stop the Make run, including its backend and frontend. This also cancels pending startup. `:ChipMindDebugStop` does the same. **Space D l** launches the last profile again after cleanup finishes.

The debug launcher waits for attachment before importing the backend, so initialization breakpoints work. If paused during initialization, the frontend and browser will open after you continue and the backend finishes startup. Uvicorn reload is disabled: stop and relaunch after changing Python code. Vite retains its normal frontend hot reload.

Make retains responsibility for its usual runtime/container setup and cleanup. Neovim runs Make from the ChipMind root resolved from the current file or working directory. Disconnecting or closing Neovim also stops a Make run launched by this profile. The Herdr tab stays open after exit so you can inspect its output; Neovim keeps focus when the tab is created.

### Ports and environment

Defaults: backend HTTP **3000**, frontend HTTP **3001**, debugger **5678** (loopback only). To use different ports:

```sh
BACKEND_PORT=3010 BACKEND_DEV_PORT=3011 DEBUG_PORT=5680 nvim
```

`BACKEND_HOST` and your normal Make environment settings, including `RUNTIME`, `EDA_PROVIDER`, `SANDBOX_RUNTIME_CONTAINER_IMAGE`, and customer-specific settings, are inherited. For a configured local process runtime, for example:

```sh
RUNTIME=local nvim
```

The profile always enables `USE_VITE=1`. Open a ChipMind Python file before selecting it. Occupied ports fail before the debug run starts services; stop the previous app or change ports.

## Start Make manually, then attach

1. In a terminal at the project root:
   ```sh
   make build  # when needed
   make run USE_VITE=1 DEBUG_BACKEND=1
   ```
2. Wait for `CHIPMIND_DEBUG_READY=5678`. Backend initialization is waiting for attachment.
3. Open Neovim from the same project root and set breakpoints.
4. Press **F5** → **ChipMind: Attach backend**. Make completes startup and opens the authenticated browser.
5. Use the same stepping controls. `:DapDisconnect` detaches without stopping the external Make run. **Ctrl-C** in its terminal stops the full app. **Space D t** terminates the attached backend, which also makes Make exit and clean up.

For a custom debug port, use `DEBUG_PORT=5680` in both the Make invocation and Neovim's environment. Plain `make run USE_VITE=1` continues to start normally without waiting for a debugger.

## Debug Python tests and scripts

1. Open a test, for example `tests/unit/events/test_command_success.py`, and set a breakpoint.
2. Place the cursor inside the test and press **Space D n** to debug the nearest pytest test. **Space D N** debugs the containing test class.
3. To debug the whole file, press **F5** → **Python: Pytest current file**.
4. **Python: Current file** runs a standalone Python script.

These profiles use the project's `.venv`, then `VIRTUAL_ENV`, then `python3`. The selected interpreter needs debugpy. Nearest-test/class discovery uses the installed Python Tree-sitter parser.

## Controls

Leader is **Space**; uppercase letters require Shift.

| Key | Action |
| --- | --- |
| F5 / Space D c | Start / continue |
| F1 / Space D i | Step into |
| F2 / Space D o | Step over |
| F3 / Space D O | Step out |
| F7 / Space D u | Toggle debugger UI |
| Space b b | Toggle breakpoint |
| Space b B | Conditional breakpoint |
| Space b l | Logpoint |
| Space D p | Pause |
| Space D e | Evaluate expression / selection |
| Space D r | Open REPL |
| Space D l | Run last profile |
| Space D t | Stop owned Make run or terminate current debugger |
| Space D n / Space D N | Debug nearest Python test / class |
| :ChipMindDebugStop | Cancel/stop Neovim-owned Make run |
| :DapDisconnect | Disconnect (also stops a Neovim-owned Make run) |

Use Fn with function keys on macOS if necessary, or use the Space mappings. In terminal-input mode, press Esc twice before using mappings. Ctrl-h/j/k/l moves between windows.

## Troubleshooting

- **Unauthorized:** use the browser window opened by Make, at the frontend port it selected. The startup script bootstraps authentication for that origin. Check its output if the browser did not open; keep `session_token_enabled` enabled.
- **Startup appears paused:** look for an initialization breakpoint in Neovim. Continue it so Make can finish starting the frontend/browser.
- **Missing debugpy:** run `make install-python-dependencies` to install the updated development dependencies. For another Python project, install it in that project's interpreter.
- **Startup error/timeout:** inspect the ChipMind Herdr tab for dependency, Docker, EDA, config, or build errors. Space D t cancels while waiting. Correct the error and run again after cleanup exits.
- **Unverified breakpoint:** use an executable line in the same checkout and ensure requests reach the selected port. Library code is skipped by `justMyCode = true`; change it in `lua/plugins/python_debug.lua` if needed.
- **Nearest test cannot be found:** run `:TSInstall python`, wait, and reopen the file; whole-file pytest debugging is also available.
- **No profiles:** open a `.py` file, restart Neovim, and inspect `:messages` / `:checkhealth dap`.

These profiles debug the host Python backend. Code in sandbox containers or native Rust/Go code needs its own debugger connection.
