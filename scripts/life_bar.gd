extends Node2D

var parent : Character

@onready var border : ColorRect = $border
@onready var lifeBar : ColorRect = $lifeBar


var maxSize
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	maxSize = lifeBar.size.x 
	print(parent.maxHealth)# Replace with function body.
	#print ("LOL", parent.maxHealth)
	#scale.x = parent.maxHealth/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifeBar.scale.x =  float(parent.health)/float(parent.maxHealth)
	if lifeBar.scale.x < 0: lifeBar.scale.x = 0

