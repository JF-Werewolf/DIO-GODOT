extends Node2D

@export var enemies: Array[PackedScene]
var minutes : int
var enemieTargetNumbers : Array = [5,3,2]
var positionTarget = Vector2.ZERO
var targetRange = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	minutes = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if minutes < gameManager.minutes:
		minutes = gameManager.minutes
		enemieTargetNumbers[0] += minutes*2.8
		enemieTargetNumbers[1] += minutes*1.5
		enemieTargetNumbers[2] += minutes*1.5

func getRunDirection():
	while true:
		positionTarget = Vector2(randf_range( -targetRange, targetRange), randf_range (-targetRange, targetRange))
		positionTarget = positionTarget + global_position
		if global_position.direction_to(positionTarget).dot(global_position.direction_to(gameManager.spawnTarget)) > 0.5:
			positionTarget = NavigationServer2D.map_get_closest_point(get_parent().navRID, positionTarget)
			break
	return positionTarget
	
func _on_timer_timeout():
	print("tentando")
	var i = randi_range(0,2)
	if gameManager.enemieNumbers[i] < enemieTargetNumbers[i]:
		var enemieScene = enemies[i] 
		var newEnemie = enemieScene.instantiate()
		newEnemie.global_position = global_position
		newEnemie.navigationTarget = getRunDirection()
		#newEnemie.stateM.changeState(newEnemie.get_node("runAway"))
		get_parent().add_child(newEnemie)
		gameManager.enemieNumbers[i] += 1
