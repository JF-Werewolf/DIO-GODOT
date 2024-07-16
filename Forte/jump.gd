extends State

@export var idleState: State
@export var walkState: State
@export var runState: State
@export var atackState: State

var NewDir : Vector2
# Called when the node enters the scene tree for the first time.
func enter():
	get_parent().isJumping = true
	super()
	 # Replace with function body.
func exit():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	
	if Input.is_action_just_pressed("atack"):
		atackState.animationName = "atack2"
		return atackState
		
	NewDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if(parent.actionFinished):
		
		if Input.is_action_just_pressed("atack"):
			return atackState
		
		if(NewDir):
			parent.ActionDir = parent.getAnimDir(NewDir)
			if(Input.is_key_pressed(KEY_SHIFT)):
				return runState
			
			return walkState
		
		return idleState
		
	if(NewDir):
		#print("LERP TEST -- CURRENT: ", get_parent().velocity, "  TARGET: ", NewDir* get_parent().Speed, "  LERP: ", get_parent().lerpFactor)
		parent.velocity = lerp(parent.velocity, parent.angle * parent.Speed, parent.lerpFactor)
		
	else: parent.velocity = lerp(parent.velocity, Vector2(0,0), parent.lerpFactor * 0.8)
	
	if Input.is_action_just_pressed("atack"):
		atackState.animationName = "atack2"
		return atackState
	
	parent.move_and_slide() 
	
