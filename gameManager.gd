extends Node2D

var player : Character 
var UI : CanvasLayer
var uiManager
var enemieNumbers : Array = [0,0,0] 
var spawnTarget = Vector2(146, 429)
var playerScore = 0

var playingGame = false

#@onready var navRID : RID  = get_world_2d().get_navigation_map()  

var minutes = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var uiScene = load("res://UI/menuUI.tscn").instantiate()
	self.add_child(uiScene)
	UI = uiScene

func startGame():
	playerScore = 0
	for x in range(enemieNumbers.size()):
		enemieNumbers[x]=0
	
	var uiScene = load("res://UI/GameUI.tscn").instantiate()
	add_child(uiScene)
	UI = uiScene
	
	for N in get_parent().get_node("World").get_children():
		if N is Character or N is Heart:
			N.queue_free()
			
	
	player = load("res://Forte/forte.tscn").instantiate()
	player.global_position = spawnTarget
	get_node("/root/World").add_child(player)
	var camera = get_node("/root/World/camera")
	camera.global_position = player.global_position
	camera.reparent(player)
	
	
	playingGame = true
	

func UIUpdate():
	UI.UIUpdate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("UI: ", gamesUI)
	pass
	
func endGame():
	UI.queue_free()
	var uiScene = load("res://UI/game_over_ui.tscn").instantiate()
	add_child(uiScene)
	UI = uiScene
	playingGame = false
