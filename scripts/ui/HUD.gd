# HUD.gd
# Main HUD that displays character info and needs

extends CanvasLayer

class_name HUD

var character: CharacterController

func _ready():
	pass

func set_character(char: CharacterController):
	character = char

func _process(delta):
	if character == null:
		return
	
	# Update display (optional)
	pass