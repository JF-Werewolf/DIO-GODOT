extends State

@export var idleState: State
@export var walkState: State
@export var runState: State
@export var jumpState: State
@export var atackState: State
@export var shieldState: State

var carryAnimation = false

var NewDir : Vector2
# Called when the node enters the scene tree for the first time.
func enter():
	if parent.stateM.previousState == shieldState:
		if parent.angle.dot(parent.global_position.direction_to(parent.atacker.global_position)) > 0.5:
			
			animationName = "shield1"
			parent.showSprite(animationName)
			parent.playAnimation(animationName, true)
			return shieldState
		
	if parent.angle.dot(parent.global_position.direction_to(parent.atacker.global_position)) > 0:
		animationName = "impact1"
	else:
		animationName = "impact2"
		
	carryAnimation = false
	parent.actionLocks.play(animationName+"_lock")
	parent.actionLocks.seek(0.0)
	parent.playAnimation(animationName, carryAnimation)
	parent.health -= parent.atacker.baseDamage
	super()
	
func exit():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	
	if(!parent.actionLock):
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
		
	get_parent().velocity = lerp(get_parent().velocity, Vector2(0,0), get_parent().lerpFactor * 1.8)
	
	get_parent().move_and_slide() 
	
	
