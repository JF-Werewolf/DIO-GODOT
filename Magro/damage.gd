extends State

@export var idleState: State
@export var atackState: State
@export var runAwayState: State
@export var dieState: State

var carryAnimation = false

var NewDir : Vector2
var timer = 10

# Called when the node enters the scene tree for the first time.
func enter():
	
	parent.health -= parent.atacker.baseDamage
	parent.velocity = parent.atacker.global_position.direction_to(parent.global_position) * (parent.atacker.strength * 10 + 100)
	animationName = "impact1"
		
	carryAnimation = false
	parent.actionLocks.play(animationName+"_lock")
	parent.actionLocks.seek(0.0)
	super()

	
func exit():
	super()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	
	if(parent.health <= 0):
			#print("F NO CHAT")
			return dieState
	#return parent.stateMachine.previousState
	
	if ! parent.actionLock:
		
		if randi_range(0, parent.maxHealth)  > parent.health*2:
			return runAwayState
		
		parent.charTarg = parent.atacker
		return atackState
	
	#if(!parent.actionLock):
		#NewDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		#
		#if(NewDir):
			#parent.angle = NewDir
			#parent.ActionDir = parent.getAnimDir(parent.angle)
			#if(Input.is_key_pressed(KEY_SHIFT)):
				#return runState
			#
			#return walkState
		#
		#if Input.is_action_just_pressed("atack"):
			##atackState.animationName = "atack2"
			#return atackState
			#
		#if Input.is_action_just_pressed("jump"):
			#return jumpState
			#
		#if Input.is_action_pressed("defend"):
			#return shieldState
		
	parent.velocity = lerp(parent.velocity, Vector2(0,0), parent.lerpFactor/3) * (delta*60) 
	
	parent.move_and_slide() 
	
	
