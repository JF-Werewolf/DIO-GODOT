extends Node2D

var player : Character 
var UI : CanvasLayer
var enemieNumbers : Array = [0,0,0] 
var spawnTarget = Vector2(146, 429)
var playerScore = 0

@onready var navRID : RID  = get_world_2d().get_navigation_map()  

var minutes = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func UIUpdate():
	UI.UIUpdate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
