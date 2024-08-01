extends Node2D

var player : Character 
var UI : CanvasLayer
var uiManager
var enemieNumbers : Array = [0,0,0] 
var enemieTargetNumbers : Array = [5,3,2]
var spawnTarget = Vector2(146, 429)
var playerScore = 0

var timeElapsed = 0.0
var minutes :int = 0
var seconds :int = 0


var playingGame = false


func _ready():
	var uiScene = load("res://UI/menuUI.tscn").instantiate()
	self.add_child(uiScene)
	UI = uiScene

func startGame():
	playerScore = 0
	
	enemieNumbers = [0,0,0]
	enemieTargetNumbers = [5,3,2]
	
	timeElapsed = 0.0
	minutes = 0
	seconds = 0
	
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
	timeElapsed += delta
	var timeInSeconds = floori(timeElapsed)
	seconds = timeInSeconds % 60
	minutes =  timeInSeconds / 60
	
	
	enemieTargetNumbers[0] += minutes*2.8
	enemieTargetNumbers[1] += minutes*1.5
	enemieTargetNumbers[2] += minutes*1.5
	
func endGame():
	UI.queue_free()
	var uiScene = load("res://UI/game_over_ui.tscn").instantiate()
	add_child(uiScene)
	UI = uiScene
	playingGame = false
