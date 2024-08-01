extends State

var time = 0
var timer = 3
var count = 0
# Called when the node enters the scene tree for the first time.

func enter():
	#print("he ded")
	if parent.atacker == gameManager.player:
		gameManager.playerScore += 12
	parent.get_node("body").queue_free()
	parent.get_node("lifeBar").queue_free()
	parent.playAnimation(animationName, false)
	time = Time.get_unix_time_from_system()
	gameManager.enemieNumbers[2] -= 1
	super()
	
func exit():
	super()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	if Time.get_unix_time_from_system() - time > timer:
		count +=1
		time = Time.get_unix_time_from_system()
		timer = 0.1
		parent.get_node(animationName + "Sprite").visible = !parent.get_node(animationName + "Sprite").visible
		if count > 6:
			parent.die()
