extends Sprite2D

@export var cur_beaver : String = "base_beaver"
@onready var beaver: Sprite2D = $"."
@onready var tail: AnimatedSprite2D = $Tail



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		beaver.texture =  load("res://Assets/beavers/"+ cur_beaver +".png")
		
	beaver.texture = load("res://Assets/beavers/"+ cur_beaver +".png")
	
	if "point" in cur_beaver:
		tail.visible = false
	else:
		tail.visible = true
