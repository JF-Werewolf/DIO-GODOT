extends State

@export var atackState: State
@export var runAwayState: State

@export var charTarg: Character

var targetSpeed = 0
var targetRange= 350
var positionTarget : Vector2 = Vector2(0,0)

var angleTarget

var red = 0

var timeStart = 0
var actionTimer = 2.0

var carryAnimation = false
#var newDir = 1

var action = 1

func enter():
	#print("Entering action: ",action)
	parent.Speed = parent.RunSpeed
	parent.angle = Vector2(1,0).rotated((parent.ActionDir + 1) * 0.785398)
	if parent.stateM.previousState == atackState:
		newAction()
	#print("ACTION DIR START: ", get_parent().ActionDir)
	#print(get_parent())
	super()
	 # Replace with function body.
func exit():
	super()
	
func get_target():
	while true:
		positionTarget = Vector2(randf_range( -targetRange, targetRange), randf_range (-targetRange, targetRange))
		positionTarget = positionTarget + parent.global_position
		if parent.angle.dot(parent.global_position.direction_to(positionTarget)) > 0:
			break
	positionTarget = NavigationServer2D.map_get_closest_point(get_parent().navRID, positionTarget)
	parent.navigationTarget = positionTarget
	
	#animationName = "stand"
	#get_parent().playAnimation(animationName, true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func newAction():
	action = randi_range(1,3)
	targetSpeed = 0
	
	#print("NORMAL: ", randfn(0.0, 1.0))
	
	if action == 1:
		timeStart = Time.get_unix_time_from_system() 
		actionTimer = randf_range(0.5, 5.0)
		#print(" WAIT ", actionTimer, "SECONDS")
		changeSprite("stand")
		carryAnimation = false
		parent.playAnimation(animationName, carryAnimation)
		
	
	if action == 2:
		angleTarget = randf_range(-PI, PI)
		#print("RAD ROTATION: ", angleTarget)
		angleTarget = parent.angle.rotated(angleTarget)
		changeSprite("stand")
		carryAnimation = false
		parent.playAnimation(animationName, carryAnimation)

	#Vector2.RIGHT.rotate(angle)
	if action == 3:
		get_target()
		changeSprite("run")
		carryAnimation = true
		#print("GET TARGET: ", get_parent().navigationTarget)
	print("Generate Action: ", action)
		
func changeSprite(newSprite):
	parent.hideSprite(animationName)
	animationName = newSprite
	parent.showSprite(animationName)
	
func checkAtack():
	if parent.get_node("weaponArea").get_overlapping_bodies().size() >1:
		var bodies = parent.get_node("weaponArea").get_overlapping_bodies()
		bodies.erase(parent)
		for body in bodies:
			if parent.angle.dot(parent.global_position.direction_to(body.global_position)) > 0.85:
				pass
				#TESTE += 1
				#print("ATACK :", TESTE,  body)
		 
	
func checkTarget():
	if parent.get_node("targetArea").get_overlapping_bodies().size() >1:
		var bodies = parent.get_node("targetArea").get_overlapping_bodies()
		bodies.erase(parent)
		for body in bodies:
			#200/50
			if(randi_range(0,120) == 50):
				if parent.angle.dot(parent.global_position.direction_to(body.global_position)) > 0:
					if parent.global_position.direction_to(body.global_position).dot(body.angle) > 0.1:
						parent.charTarg = body
						print("LOL")
						return true
						
						
func processPhysics(delta):	
	
	if action == 0:
		newAction()
		
	if action == 1:
		if(Time.get_unix_time_from_system() - timeStart > actionTimer):
			action = 0
		
	if action == 2:
		if(parent.angle.angle() < angleTarget.angle()):
			#print("LEFT")
			#print("CURRENT ANGLE: ", currentAngle.angle())
			parent.angle = parent.angle.rotated(0.085)
		if(parent.angle.angle() > angleTarget.angle()):
			#print("RIGHT---------")
			#print("CURRENT ANGLE: ", currentAngle.angle())
			parent.angle = parent.angle.rotated(-0.085)
		
		#newDir = parent.getAnimDir(parent.angle)
		
		if(abs(parent.angle.angle() - angleTarget.angle()) < 0.1):
			action = 0
		
	if action == 3:
		parent.angle = parent.global_position.direction_to(parent.navigationAgent.get_next_path_position())
		targetSpeed = parent.RunSpeed
		#newDir = parent.getAnimDir(parent.angle)
		
		
		if((positionTarget - parent.global_position).length() < 10):
			action = 0
			
		#checkAtack()
	
	if parent.getAnimDir(parent.angle) != parent.ActionDir:
		parent.ActionDir = parent.getAnimDir(parent.angle) 
		parent.playAnimation(animationName, carryAnimation)
	
	parent.velocity = lerp(parent.velocity, parent.angle*targetSpeed, parent.lerpFactor /3)
	parent.move_and_slide()
	
	if checkTarget():
		print("ATACANDO")
		return atackState
	
	
	
	
	
	
	
	#if(! positionTarget):
		#if(Time.get_unix_time_from_system() - timeStart  > actionTimer):
			#var action = randi_range(1,3)
			#
			#match action:
				#1:
					#pass
				#2:
					#newDir = randi_range(1,8)
				#3:
					#get_parent().hideSprite(animationName)
					#animationName = "run"
					#carryAnimation = true
					#get_parent().showSprite(animationName)
					#get_target()
					#
					#
			#timeStart = Time.get_unix_time_from_system()
			#actionTimer = randf_range(0.0, 5.0)
			#print(action)
	#
	#else:
		#normalDiff = get_parent().global_position.direction_to(get_parent().navigationAgent.get_next_path_position())
		##normalDiff = get_parent().navigationAgent.get_next_path_position() - get_parent().global_position
		##normalDiff = normalDiff.normalized()
		##get_parent().velocity = direction * 140
		#get_parent().velocity = lerp(get_parent().velocity, normalDiff * get_parent().Speed, get_parent().lerpFactor * 1.8)
		#get_parent().move_and_slide()
		#newDir = get_parent().getAnimDir(normalDiff)
		#
		#
		#if((positionTarget - get_parent().global_position).length() < 6):
			#print("ANGLE: ", normalDiff.angle())
			##red+=1
			##print("TARGET LEN: ", target.length(),  get_parent().global_position.length(), red)
			#positionTarget = Vector2.ZERO
			#get_parent().hideSprite(animationName)
			#animationName = "stand"
			#carryAnimation = false
			#get_parent().showSprite(animationName)

		
	#if newDir != get_parent().ActionDir:
		#get_parent().ActionDir = newDir 
		#get_parent().showSprite(animationName)
		#get_parent().playAnimation(animationName, carryAnimation)
	
	
	#get_parent().move_and_slide()
	#get_parent().velocity = Vector2(40,40)
	#get_parent().velocity = lerp(get_parent().velocity, normalDiff * get_parent().Speed, get_parent().lerpFactor * 1.8)
	
	#get_parent().move_and_slide() 
