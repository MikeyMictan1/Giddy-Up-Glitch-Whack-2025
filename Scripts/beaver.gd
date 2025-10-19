extends Sprite2D

@export var cur_beaver : String = "base_beaver"
@onready var beaver: Sprite2D = $"."
@onready var tail: AnimatedSprite2D = $Tail
@onready var happy: Sprite2D = $Happy
@onready var sad: Sprite2D = $Sad

func _ready() -> void:
	happy.visible = false
	sad.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		beaver.texture =  load("res://Assets/beavers/"+ cur_beaver +".png")
		
	beaver.texture = load("res://Assets/beavers/"+ cur_beaver +".png")
	
	if "point" in cur_beaver:
		tail.visible = false
	else:
		tail.visible = true
	
	if beaver.flip_h == true:
		tail.flip_h = true
		tail.position = Vector2(-120, 36)
	else:
		tail.flip_h = false
		tail.position = Vector2(158, 36)

func make_happy():
	happy.visible = true
	sad.visible = false

func make_sad():
	happy.visible = false
	sad.visible = true

func make_normal():
	happy.visible = false
	sad.visible = false
