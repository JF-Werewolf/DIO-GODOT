extends State

@export var standState: State
@export var runState: State
@export var jumpState: State
@export var atackState: State
@export var shieldState: State

var NewDir : Vector2

# Called when the node enters the scene tree for the first time.
func enter():
	super()
	parent.Speed = parent.WalkSpeed
func exit():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	
	if Input.is_action_just_pressed("atack"):
		atackState.animationName = "atack1"
		return atackState
		
	parent.angle = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if(parent.angle):
		#print("DIR: ", get_parent().newDir)
		if parent.getAnimDir(parent.angle) != parent.ActionDir:
			parent.ActionDir = parent.getAnimDir(parent.angle) 
			parent.playAnimation(animationName, true)
	
		if(Input.is_key_pressed(KEY_SHIFT)):
			return runState
	else:
		return standState
		
	if Input.is_action_just_pressed("jump"):
		return jumpState
		
	if Input.is_action_pressed("defend"):
		return shieldState
		
	parent.velocity = parent.angle * parent.Speed
	parent.lerpFactor = 0.20
	
	
	parent.move_and_slide() 
	
