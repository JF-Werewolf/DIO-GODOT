class_name State
extends Node

@export var animationName: String

#@onready var stateMachine = get_node("../stateMachine")

var parent: Character
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func enter():
	#print("LOLOLOL:", get_parent().is_node_ready ( ))
	parent.showSprite(animationName)
	parent.playAnimation(animationName,false) 

func exit():
	parent.hideSprite(animationName)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	return null
	
func processInput(event: Input):
	return null 
	
func process(delta):
	return null
