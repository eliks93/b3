extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game = preload("res://Game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().request_lobby_update()

func _on_Button_pressed():
	get_parent().join_game(GameState.room_info.name)
	# Give a joining popup here if necessary, swap scene once the server says it's okay to.
	
# This will be called if Core.join_game succeeded.
func room_join_success(room_info):
	var room = game.instance()
	room.name = room_info
	get_parent().swap_scene(get_node("."), room)
# This will be called if Core.join_game failed.

func update(room_list):
	$RoomList/listNames.clear()
	$RoomList/listPlayers.clear()
	for room in room_list:
		$RoomList/listNames.add_item(room)
		$RoomList/listPlayers.add_item(str(room_list[room].players) + "/" + str(room_list[room].max_players))

func _on_listNames_item_selected(index):
	GameState.room_info.name = $RoomList/listNames.get_item_text(index)




































