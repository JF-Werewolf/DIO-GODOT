class_name Heart
extends Node2D

@onready var area : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.visible = true
	area.body_entered.connect(on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_body_entered(body):
	#print("MANAGER: ", gameManager.player)
	#if body == gameManager.player:
		#gameManager.player.heal(10)
		#gameManager.player.heartCollected.emit(10)
		#queue_free()
	body.heal(10)
	queue_free()
	
