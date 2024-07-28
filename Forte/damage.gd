extends State

@export var idleState: State
@export var walkState: State
@export var runState: State
@export var jumpState: State
@export var atackState: State
@export var shieldState: State
@export var dieState: State

var carryAnimation = false

var NewDir : Vector2
# Called when the node enters the scene tree for the first time.
func enter():
	#print("PREVIOUS: ", parent.stateM.previousState)
	if parent.stateM.previousState == shieldState:
		if parent.angle.dot(parent.global_position.direction_to(parent.atacker.global_position)) > 0.3:
			#print("DEFESA")
			return shieldState
	
	#print("DANO")
	parent.health -= parent.atacker.baseDamage 
	parent.healthPercentage = float(parent.health)/float(parent.maxHealth)
	gameManager.UIUpdate()
	if parent.angle.dot(parent.global_position.direction_to(parent.atacker.global_position)) > 0:
		animationName = "impact1"
	else:
		animationName = "impact2"
		
	carryAnimation = false
	parent.actionLocks.play(animationName+"_lock")
	parent.actionLocks.seek(0.0)
	parent.playAnimation(animationName, carryAnimation)
	super()
	
func exit():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	if parent.health < 0: 
		return dieState
	
	if(!parent.actionLock):
		if Input.is_action_pressed("defend"):
			return shieldState
			
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
		
	parent.velocity = lerp(parent.velocity, Vector2(0,0), parent.lerpFactor * 1.8) * (delta*60)
	
	parent.move_and_slide() 
	
	
