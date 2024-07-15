extends CharacterBody2D


@export var SPEED = 170
@export_range(0,1) var lerpFactor = 0.5

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer 
@onready var sprite: Sprite2D 

#@onready var icon = $walkSprite
#@onready var animCon = $AnimationTree

class State:
	enum States{
		Stand,
		Walk,
		Run,
		Jump,
		Atack1,
		Atack2,
		Atack3
	}
	
	var currentState = States.Stand
	
	func input(event):
		match currentState: 
			States.Stand: inputStand(event)
			#States.Walk:  inputWalk(event)
			#States.Run:   inputRun(event)
			#States.Jump:  inputJump(event)
			#States.Atack: inputAtack(event)
		
	func inputStand(event):
		
			
				
				


var animationPlaying = "stand"
var animDir = 1

var newAnimation = "stand"
var newDir = 1

var direction: Vector2

var lockAction: bool


func playAnimation(animation, direction):
	
	if(animation != animationPlaying || direction != animDir):
		var position = 0.0
		if(animation != animationPlaying):
			sprite = get_node(animationPlaying+"Sprite")
			sprite.visible = false
			sprite = get_node(animation+"Sprite")
			sprite.visible = true
		
		else: position = animationPlayer.current_animation_position

		animationPlayer.play(animation+"_"+str(direction))
		animationPlayer.seek(position)
		
		animationPlaying = animation
		animDir = direction
	
func getAnimDir(vec):
	var dir = int(round((vec.angle()) / 0.785398))
	#print(dir)
	if(dir >= 2): return dir-1
	else: return dir+7
	
func _ready():
	playAnimation("stand", 1)
	newDir = 1


func _physics_process(delta):
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if(direction):
		newDir = getAnimDir(direction)
		
		if(Input.is_key_pressed(KEY_SHIFT)): 
			newAnimation = "run"
			SPEED = 260
		else: 
			newAnimation = "walk"
			SPEED = 170
	
	else: newAnimation = "stand"
	
	if Input.is_action_just_pressed("atack"): 
		lockAction = true
		newAnimation = "atack3"
		SPEED *= 0.3
	
	playAnimation(newAnimation, newDir)
	
	var targetVelocity = direction * SPEED
	velocity = lerp(velocity, targetVelocity, lerpFactor)
	
	#animationPlayer.ap.animation_finished.connect(_on_animation_done)
	move_and_slide()
	
	
