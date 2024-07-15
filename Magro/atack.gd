extends State

@export var idleState: State
@export var runAwayState: State

var carryAnimation = false

var targetSpeed : Vector2

var action : int
var atackLock

var timeStart = 0

var TESTE = 0

func changeSprite(name):
	parent.hideSprite(animationName)
	animationName = name
	parent.showSprite(animationName)
	
func enter():
	action = 1
	animationName = "run"
	carryAnimation = true
	atackLock = true
	super()
	 # Replace with function body.
func exit():
	super()
	
func checkAtack():
	
	if parent.get_node("weaponArea").overlaps_body(parent.charTarg):
		if parent.angle.dot(parent.global_position.direction_to(parent.charTarg.global_position)) > 0.85:
			#print("DAMAGE: ", body)
			TESTE += 1
			parent.charTarg.atacker = parent 
			if parent.charTarg.get_node("damage"):
				parent.charTarg.stateM.changeState(parent.charTarg.get_node("damage"))
			#print("ATAQUES: ", TESTE)
			return true
				
	#if parent.get_node("weaponArea").get_overlapping_bodies().size() >1:
		#var bodies = parent.get_node("weaponArea").get_overlapping_bodies()
		#bodies.erase(parent)
		#for body in bodies:
			#if parent.angle.dot(parent.global_position.direction_to(body.global_position)) > 0.85:
				##print("DAMAGE: ", body)
				#return true

func newAction():
	pass


func processPhysics(delta):	
	
	if ! parent.charTarg.get_node("body"):
		print("MATOU")
		return idleState
	
	if action == 0:
		newAction()
	
	if action == 1:
		
		parent.navigationTarget = parent.charTarg.global_position
		parent.angle = parent.global_position.direction_to(parent.navigationAgent.get_next_path_position())
		
		if atackLock:
			targetSpeed = parent.angle.rotated(PI) * parent.RunSpeed
			if (parent.navigationTarget - parent.global_position).length() >100:
				atackLock = false
		
		
		else:
			targetSpeed = parent.angle * parent.RunSpeed
			if (parent.navigationTarget - parent.global_position).length() <110:
				targetSpeed *=2
			
			if(checkAtack()):
			#print("LOL")
				parent.velocity = targetSpeed.rotated(PI) * 0.8 
				targetSpeed = Vector2.ZERO
				timeStart = Time.get_unix_time_from_system()
				action = 2
				changeSprite("stand")
				carryAnimation = false
				parent.playAnimation(animationName, carryAnimation)
			
	
	if action == 2:
		if Time.get_unix_time_from_system() - timeStart < 0.6:
			pass
		else: 
			action = 1
			changeSprite("run")
			carryAnimation = true
			parent.playAnimation(animationName, carryAnimation)
			atackLock = true
		
		
	parent.velocity = lerp(parent.velocity, targetSpeed, parent.lerpFactor /3)
	parent.move_and_slide()
	
	if parent.getAnimDir(parent.angle) != parent.ActionDir:
		parent.ActionDir = parent.getAnimDir(parent.angle) 
		parent.playAnimation(animationName, carryAnimation)
	
	
	#get_parent().velocity = Vector2(40,40)
	#get_parent().velocity = lerp(get_parent().velocity, normalDiff * get_parent().Speed, get_parent().lerpFactor * 1.8)
	
	#get_parent().move_and_slide() 
