# MultiplayerManager.gd
# Manages multiplayer lobbies and player spawning

extends Node

class_name MultiplayerManager

var peer = null
var players = {}

signal player_joined(peer_id: int)
signal player_left(peer_id: int)

func _ready():
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(peer_id: int):
	print("Player joined: %d" % peer_id)
	player_joined.emit(peer_id)

func _on_peer_disconnected(peer_id: int):
	print("Player left: %d" % peer_id)
	if peer_id in players:
		players.erase(peer_id)
	player_left.emit(peer_id)

func start_server(port: int = 8888):
	peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	multiplayer.set_multiplayer_peer(peer)
	print("Server started on port %d" % port)

func join_server(host: String, port: int = 8888):
	peer = ENetMultiplayerPeer.new()
	peer.create_client(host, port)
	multiplayer.set_multiplayer_peer(peer)
	print("Connecting to server at %s:%d" % [host, port])