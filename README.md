# Michel's UUID Tools

A simple **UUID generator plugin for Godot** that lets you generate UUIDs inside the editor and in-game and keeps a **history of generated UUIDs** in a file for later reference.

---

## Features

- Generate UUIDs directly in the Godot editor
- Automatically save a history of generated UUIDs to a file
- Prevent accidental reuse by checking against the history (if applicable)
- Simple, lightweight plugin – no external dependencies

---

## Installation

1. Download or clone this repository:

   ```bash
   git clone https://github.com/cilissen/godot-plugin-michels-uuid-tools.git

2. Copy the ```addons/michels_uuid_tools``` directory into your Godot project's ```res://addons/``` folder.

3. Open your project in Godot.

4. Go to Project > Project Settings > Plugins.

5. Find **Michel's UUID Tools** and set it to Enabled.

## Usage

### From the Editor UI

Open the UUID generator panel from:
Editor > Editor Docks > UUID or via the Dock named UUID.

Click Generate to create a new UUID.

### From GDScript (in-game)

 ```gdscript
 var uuid:String = UUID.new_uuid() # It's a static function you can use anywhere
 print(uuid)
 ```

Output:

```
542b5deb-a875-644e-e9b9-912763bc909d
```
