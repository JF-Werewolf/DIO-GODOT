extends Node2D

@export var enemies: Array[PackedScene]
var positionTarget = Vector2.ZERO
var targetRange = 400

#@onready var navRID : RID  = get_world_2d().get_navigation_map()  
# Called when the node enters the scene tree for the first time.
func _ready():
	#print("ENEMIE: ", enemies[1])
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getRunDirection():
	while true:
		positionTarget = Vector2(randf_range( -targetRange, targetRange), randf_range (-targetRange, targetRange))
		positionTarget = positionTarget + global_position
		if global_position.direction_to(positionTarget).dot(global_position.direction_to(gameManager.spawnTarget)) > 0.5:
			positionTarget = NavigationServer2D.map_get_closest_point(get_parent().navRID, positionTarget)
			break
	return positionTarget
	
func _on_timer_timeout():
	if gameManager.playingGame:
		var i = randi_range(0,2)
		if gameManager.enemieNumbers[i] < gameManager.enemieTargetNumbers[i]:
			var enemieScene = enemies[i] 
			var newEnemie = enemieScene.instantiate()
			newEnemie.global_position = global_position
			newEnemie.navigationTarget = getRunDirection()
			#newEnemie.stateM.changeState(newEnemie.get_node("runAway"))
			get_parent().add_child(newEnemie)
			gameManager.enemieNumbers[i] += 1
