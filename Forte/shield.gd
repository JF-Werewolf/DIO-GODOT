extends State

@export var idleState: State
@export var walkState: State
@export var runState: State
@export var atackState: State
@export var jumpState: State
@export var damageState: State

var animationCarry : bool

var NewDir : Vector2
# Called when the node enters the scene tree for the first time.
func enter():
	super()
	if parent.stateM.previousState == damageState:
		parent.animationPlayer.seek(0.07)
	animationCarry = true
	#parent.angle = Vector2(1,0).rotated((parent.ActionDir + 1) * 0.785398)
	 # Replace with function body.
func exit():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	
	if Input.is_action_just_pressed("atack"):
		#atackState.animationName = "atack1"
		return atackState
		
	NewDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if NewDir:
		parent.angle = NewDir
		parent.ActionDir = parent.getAnimDir(NewDir)
		parent.playAnimation(animationName, animationCarry)
		
	if Input.is_action_just_released("defend"):
		if NewDir:
			if(Input.is_key_pressed(KEY_SHIFT)):
				return runState
		
			return walkState
		else:	
			return idleState
	
		
	if Input.is_action_just_pressed("jump"):
		return jumpState
		
		
	parent.velocity = lerp(parent.velocity, Vector2(0,0), parent.lerpFactor)
	
	parent.move_and_slide() 
