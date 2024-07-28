extends State

@export var idleState: State
@export var runAwayState: State

var carryAnimation = false

var targetSpeed : Vector2

var action : int
var tooClose : bool

var timeStart = 0 
var chaseStart = 0
var lastHit = 0

var TESTE = 0

func changeSprite(name):
	parent.hideSprite(animationName)
	animationName = name
	parent.showSprite(animationName)
	
func enter():
	action = 1
	animationName = "walk"
	carryAnimation = true
	chaseStart = Time.get_unix_time_from_system()
	lastHit = chaseStart
	
	super()
	 # Replace with function body.
func exit():
	super()
	
func checkTarget():
	if parent.get_node("weaponArea").overlaps_body(parent.charTarg):
		if parent.angle.dot(parent.global_position.direction_to(parent.charTarg.global_position)) > 0.85:
			return true
			
func checkAtack():
	lastHit  = Time.get_unix_time_from_system()
	
	if parent.get_node("weaponArea").get_overlapping_bodies().size() >1:
		var bodies = parent.get_node("weaponArea").get_overlapping_bodies()
		bodies.erase(parent)
		for body in bodies:
			if parent.angle.dot(parent.global_position.direction_to(body.global_position)) > 0.1:
				body.takeDamage(parent)

func processPhysics(delta):	
	
	if action == 1:
		
		parent.navigationTarget = parent.charTarg.global_position
		parent.angle = parent.global_position.direction_to(parent.navigationAgent.get_next_path_position())
		
		
		targetSpeed = parent.angle * parent.WalkSpeed
		
		if(checkTarget()):
			lastHit  = Time.get_unix_time_from_system()
			animationName = "atack1"
			changeSprite(animationName)
			carryAnimation = false
			parent.playAnimation(animationName, carryAnimation)
			parent.actionLocks.play(animationName+"_lock")
			parent.actionLocks.seek(0.0)
			
			targetSpeed = Vector2.ZERO
			action = 2
			print("Action: ", action )
		
		if parent.global_position.distance_to(parent.charTarg.global_position) > 350 - (80*parent.charTarg.healthPercentage):
			#print ("DISTANCE: ", 350 - (80*parent.charTarg.healthPercentage))
			return idleState
			
		
	
	if action == 2:
		if Time.get_unix_time_from_system() - lastHit < 0.5:
			pass
		else: 
			action = 1
			changeSprite("walk")
			carryAnimation = true
			parent.playAnimation(animationName, carryAnimation)
			print("Action: ", action )
		
		
		
	parent.velocity = lerp(parent.velocity, targetSpeed, parent.lerpFactor /3) * (delta*60)
	parent.move_and_slide()
	
	if parent.getAnimDir(parent.angle) != parent.ActionDir:
		parent.ActionDir = parent.getAnimDir(parent.angle) 
		parent.playAnimation(animationName, carryAnimation)
	
	if ! parent.charTarg.get_node("body"):
		#print("MATOU")
		return idleState
	
	#get_parent().velocity = Vector2(40,40)
	#get_parent().velocity = lerp(get_parent().velocity, normalDiff * get_parent().Speed, get_parent().lerpFactor * 1.8)
	
	#get_parent().move_and_slide() 
