extends Control

var msg : String = ""
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Panel/Label.text = msg

func _process(delta: float) -> void:
	timer += delta
	if timer >= 3:
		queue_free()
