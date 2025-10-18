extends CanvasLayer
@onready var text = $MarginContainer/Panel/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	text.update_label_text()
	pass # Replace with function body.
