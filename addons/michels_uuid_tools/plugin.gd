@tool
extends EditorPlugin

var control_dock: Control

func _enter_tree() -> void:
	control_dock = preload("res://addons/michels_uuid_tools/control_dock.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR, control_dock)

func _exit_tree() -> void:
	remove_control_from_docks(control_dock)
	control_dock.queue_free()
