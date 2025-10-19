extends Label
var coins  = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_makeCoins()

func _makeCoins () -> void:
	text = "Brevan Bucks: " + str(BrevanGlobal.bucks)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
