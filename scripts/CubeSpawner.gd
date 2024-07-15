extends Node

@export var objectTemplates: Array[PackedScene]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	#check if event is a left click
	if event is InputEventMouseButton:
		if event.button_index ==1:
			if event.pressed:
				spawnObject(event.position)
	pass

func spawnObject(position: Vector2) ->void:
	var index : int = randi_range(0,objectTemplates.size() - 1)
	var objectTemplate = objectTemplates[index]
	var object = objectTemplate.instantiate()
	object.position = position
	add_child(object) 
	
	pass
