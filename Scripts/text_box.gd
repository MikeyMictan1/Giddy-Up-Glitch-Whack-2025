extends CanvasLayer
@onready var text = get_node("MarginContainer/Panel/MarginContainer/VBoxContainer/Label")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	text.update_label_text()
	pass # Replace with function body.
