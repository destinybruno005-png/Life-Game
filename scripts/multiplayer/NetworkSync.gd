# NetworkSync.gd
# Synchronizes player data across network

extends Node

class_name NetworkSync

var character: CharacterController

func _ready():
	pass

func set_character(char: CharacterController):
	character = char

@rpc("unreliable")
func sync_position(pos: Vector2):
	if character != null:
		character.global_position = pos

@rpc("unreliable")
func sync_needs(needs_data: Dictionary):
	if character != null:
		for need_name in needs_data:
			character.needs_system.set_need(need_name, needs_data[need_name])