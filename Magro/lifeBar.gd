extends ColorRect

var parent : Character


var maxSize
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_parent()
	maxSize = size.x # Replace with function body.
	print ("LOL", parent.maxHealth)
	scale.x = parent.maxHealth/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale.x =  float(parent.health)/float(parent.maxHealth)
	if scale.x < 0: scale.x = 0

