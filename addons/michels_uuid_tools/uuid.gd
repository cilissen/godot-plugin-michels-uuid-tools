class_name UUID
## A fully static Class that handles UUID generation and history both in editor and in-game.[br][br]
## Use the [code]new_uuid()[/code] function to easily generate a new UUID from anywere.

## An array holding the 16 different string values for the base-16 number system (0-F).
const _HEXADECIMALS:Array[String] = [
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
	"a", "b", "c", "d", "e", "f"
]

## Path to the .dat file in persistent user data.
const _UUID_HISTORY_PATH_APPDATA:String = "user://uuid.dat"
## Path to the .txt file in the plugin folder.
const _UUID_HISTORY_PATH_EDITOR:String = "res://addons/michels_uuid_tools/uuid_history.txt"

## Public function to generate a new UUID that by default is ensured unique and saved to 
## the appropriate UUID history file.
static func new_uuid(unique=true, save=true) -> String:
	var uuids:Array[String] = _load_uuid_history() # Load UUID history
	var uuid:String = _uuid() # Generate a new random UUID
	while unique and uuid in uuids: uuid = _uuid()  # Generate a new one if not unique
	if save: save_uuid(uuid) # Saves the new random UUID to UUID history
	return uuid

## Public function to save a UUID to the appropriate UUID history file.
static func save_uuid(uuid:String) -> void:
	uuid = uuid.to_lower().strip_edges() # Convert to lowercase and strips spaces, tabs, etc. from edges
	if not is_valid_uuid(uuid): return # If it's not a valid UUID format there is no need to save
	var uuids:Array[String] = _load_uuid_history() # Load all the UUID history
	if uuid in uuids: return # If already in history there is no need to save
	uuids.append(uuid) # Add the new UUID to the array of used UUIDs
	if OS.has_feature("editor"): _save_to_file(_UUID_HISTORY_PATH_EDITOR, "\n".join(uuids)) # If it's the editor then save to the .txt file in the plugin folder
	else: _save_dat_var(_UUID_HISTORY_PATH_APPDATA, "\n".join(uuids)) # If it's the build game then save to the .dat file in persistent user data

## Public function to check if an UUID is a valid UUID string.
static func is_valid_uuid(uuid:String) -> bool:
	uuid = uuid.to_lower().strip_edges() # Convert to lowercase and strips spaces, tabs, etc. from edges
	if uuid.count("-") == 4: uuid = uuid.replace("-", "") # Strip away the 4 dashes
	if not len(uuid) == 32: return false # If it's not the correct length then it's not a valid UUID
	for c in uuid: if c not in _HEXADECIMALS: return false # If it contains a character that's not hexadecimal then it is an invalid UUID
	return true # If it passes all checks then it must be a valid UUID

## Private function to generate a random UUID, no checking if unique, no saving to history.
static func _uuid() -> String:
	var uuid:String
	for i in range(32):
		if (i == 8 or i == 12 or i == 16 or i == 20): uuid += "-" # Add the formatting hyphens at the correct places
		uuid += _HEXADECIMALS.pick_random() # For 32 iterations pick a random hexadecimel to construct a 32 character UUID
	return uuid

## Private function to store a string to a textfile.
static func _save_to_file(path:String, contents:String):
	FileAccess.open(path, FileAccess.WRITE).store_string(contents)

## Private function to load a string from a textfile.
static func _load_from_file(path:String) -> String:
	return FileAccess.open(path, FileAccess.READ).get_as_text()

## Private function to save a variant to a file.
static func _save_dat_var(path:String, value:Variant) -> void:
	var file:Object = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(value)

## Private function to load a variant from a file.
static func _load_dat_var(path:String) -> Variant:
	var file:Object = FileAccess.open(path, FileAccess.READ)
	return file.get_var()

## Private function to load the history from the file in the plugin folder and 
## the file in persistent user data.
static func _load_uuid_history() -> Array[String]:
	var uuids:Array[String] = []
	if FileAccess.file_exists(_UUID_HISTORY_PATH_EDITOR):
		var contents:String = _load_from_file(_UUID_HISTORY_PATH_EDITOR)
		for u in contents.split("\n"):
			if u not in uuids and is_valid_uuid(u):
				uuids.append(u)
	if FileAccess.file_exists(_UUID_HISTORY_PATH_APPDATA):
		var contents:String = _load_dat_var(_UUID_HISTORY_PATH_APPDATA)
		for u in contents.split("\n"):
			if u not in uuids and is_valid_uuid(u):
				uuids.append(u)
	return uuids
