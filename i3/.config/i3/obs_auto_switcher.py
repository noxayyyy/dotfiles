#!/usr/bin/env python3
import sys
from i3ipc.aio import Connection
from i3ipc import Event
import obsws_python as obs
import asyncio

# --- CONFIGURATION ---
OBS_HOST = "localhost"
OBS_PORT = 4455
OBS_PASSWORD = "L4rj32JpkE2HZJc5"

# Map your i3 output names to your exact OBS Scene names
WORKSPACE_TO_SCENE = {
    "3" : "DP",
    "1" : "HDMI",
}
# ---------------------

# Connect to OBS WebSocket
try:
    obs_client = obs.ReqClient(host=OBS_HOST, port=OBS_PORT, password=OBS_PASSWORD)
    print("Connected to OBS Studio!")
except Exception as e:
    print(f"Could not connect to OBS. Is it running? Error: {e}")
    sys.exit(1)

last_scene = None

def on_focus_change(_, e):
    global last_scene
    scene_name = WORKSPACE_TO_SCENE.get(e.current.name)

    if scene_name == last_scene or not scene_name:
        return
    try:
        obs_client.set_current_program_scene(scene_name)
        print(f"Focus changed to {e.current.name} -> Switched OBS to '{scene_name}'")
        last_scene = scene_name
    except Exception as err:
        print(f"Failed to switch scene in OBS: {err}")

async def main():
    i3 = await Connection().connect()
    i3.on(Event.WORKSPACE_FOCUS, on_focus_change)
    await i3.main()

if __name__ == "__main__":
    print("Listening for i3 focus changes...")
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("Exiting...")
