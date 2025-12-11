@tool
extends Control

@onready var uuid_line_edit: LineEdit = $VBoxContainer/UUIDLineEdit
@onready var unique_uuid_check_box: CheckBox = $VBoxContainer/UniqueUUIDCheckBox
@onready var copy_to_clipboard_check_box: CheckBox = $VBoxContainer/CopyToClipboardCheckBox

func _on_generate_button_pressed() -> void:
	uuid_line_edit.text = UUID.new_uuid(unique_uuid_check_box.button_pressed)
	if copy_to_clipboard_check_box.button_pressed: _on_clipboard_button_pressed()

func _on_clipboard_button_pressed() -> void:
	if UUID.is_valid_uuid(uuid_line_edit.text): DisplayServer.clipboard_set(uuid_line_edit.text)
