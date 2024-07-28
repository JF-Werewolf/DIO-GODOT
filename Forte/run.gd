extends State

@export var standState: State
@export var walkState: State
@export var jumpState: State
@export var atackState: State
@export var shieldState: State

var NewDir : Vector2
# Called when the node enters the scene tree for the first time.
func enter():
	super()
	parent.Speed = get_parent().RunSpeed
	 # Replace with function body.
func exit():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
		
	NewDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if(NewDir):
		parent.angle = NewDir
		if parent.getAnimDir(parent.angle) != parent.ActionDir:
			parent.ActionDir = parent.getAnimDir(parent.angle) 
			parent.playAnimation(animationName, true)
	
		if(not Input.is_key_pressed(KEY_SHIFT)):
			return walkState
	else:
		return standState
		
	if Input.is_action_just_pressed("atack"):
		#atackState.animationName = "atack1"
		return atackState
		
	if Input.is_action_just_pressed("jump"):
		return jumpState
		
	if Input.is_action_pressed("defend"):
		return shieldState
		
	parent.velocity = parent.angle * parent.Speed * (delta*60)
	parent.lerpFactor = 0.08
	
	
	parent.move_and_slide() 
