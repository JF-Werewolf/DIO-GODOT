extends State

@export var walkState: State
@export var runState: State
@export var jumpState: State
@export var atackState: State
@export var shieldState: State

var NewDir : Vector2
# Called when the node enters the scene tree for the first time.
func enter():
	super()
	 # Replace with function body.
func exit():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	NewDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if(NewDir):
		parent.angle = NewDir
		parent.ActionDir = parent.getAnimDir(parent.angle)
		if(Input.is_key_pressed(KEY_SHIFT)):
			return runState
		
		return walkState
	
	if Input.is_action_just_pressed("atack"):
		#atackState.animationName = "atack2"
		return atackState
		
	if Input.is_action_just_pressed("jump"):
		return jumpState
		
	if Input.is_action_pressed("defend"):
		return shieldState
		
	parent.velocity = lerp(parent.velocity, Vector2(0,0), parent.lerpFactor * 1.8)
	
	parent.move_and_slide() 
	
	
	

