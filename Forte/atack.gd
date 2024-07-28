extends State

@export var standState: State
@export var walkState: State
@export var runState: State
@export var jumpState: State
@export var shieldState: State

var newDir : Vector2

var chain : int = 0
var atack = 1
var AnimCarry = 0

var time_start = 0
var time_now = 0

var previousAtack : int = 0

var teste = 0

#get_node("../stateMachine")
# Called when the node enters the scene tree for the first time.
func enter():
	chain=0
	#print("STATE MACHINE: ", sm)
	if parent.stateM.previousState == jumpState:
		animationName = "atack1" 
		parent.atackRange = 0.0
		AnimCarry = true
	
	else:
		animationName = "atack" + str(newAtack())
		AnimCarry = false

	#parent.atackLock = true
	playAnimation()
	#checkAtack()
	
	AnimCarry = false
	#AnimCarry = false
	#super()
	 # Replace with function body.
func exit():
	#print("DURATION: ", time_start - Time.get_unix_time_from_system())
	parent.atackLock = false
	super()

func newAtack():
	var atack = randi_range(2,4)
	while true:
		if atack != previousAtack:
			previousAtack = atack
			parent.atackRange = 0.35
			return atack
		else: 
			atack = randi_range(2,4)
	
func checkAtack():
	#print("CHECKING ATACK")
	if parent.get_node("weaponArea").get_overlapping_bodies().size() >1:
		var bodies = parent.get_node("weaponArea").get_overlapping_bodies()
		bodies.erase(parent)
		for body in bodies:
			if parent.angle.dot(parent.global_position.direction_to(body.global_position)) > parent.atackRange:
				body.atacker = parent
				body.stateM.changeState(body.get_node("damage"))
				#return true
				
	
func playAnimation():
	#print("ATACK: ", animationName )
	#parent.atackLock = true
	#parent.showSprite(animationName)
	parent.actionLocks.play(animationName+"_lock")
	parent.actionLocks.seek(0.0)
	parent.playAnimation(animationName,AnimCarry)
	#parent.actionLocks.play(animationName+"_lock")
	#get_parent().hideSprite(animationName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):
	#print(chain)
	newDir = Vector2(0,0)
	
	if animationName == "atack1" && parent.animationPlayer.current_animation_position < 0.75:
		#print("FRAME: ", get_parent().animationPlayer.current_animation_position)
		newDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if(!parent.atackLock):
			
		if Input.is_action_just_pressed("atack"): 
			newDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			if newDir:
				parent.angle = newDir
				parent.ActionDir = parent.getAnimDir(parent.angle) 
				
			#hideSprite()
			if chain >= 4:
				animationName = "atack6"
				parent.atackRange = -1.0
				chain = 0
			
			else:
			
				animationName = "atack" + str(newAtack())
				#checkAtack()
				chain += 1
				
			playAnimation()
			print('CHAIN: ', chain)
			
		if Input.is_action_pressed("defend"):
			return shieldState
	
	
	if newDir:
		parent.angle = newDir
		
	parent.velocity = lerp(parent.velocity, newDir*parent.Speed, parent.lerpFactor ) * (delta*60)
	parent.move_and_slide() 
	
	if parent.actionFinished:
		#print("GOING TO STAND")
		#print ("LOCK: ", parent.atackLock)
		return standState
	
