extends State

@export var atackState: State
@export var idleState: State
var NewDir : Vector2

var target : Vector2 = Vector2(0,0)
var runDirection

var targetRange= 250
var positionTarget : Vector2 = Vector2.ZERO

var carryAnimation = true

func enter():
	get_target()
	super()
	 # Replace with function body.
func exit():
	super()

func get_target():
	runDirection = parent.scapeRoute()
	if runDirection:
		target = runDirection
		#print("target: ", runTarget)
		
	positionTarget = target.rotated(randf_range(-0.3, 0.3))
	positionTarget *= 200
			
	positionTarget += parent.global_position
		
	positionTarget = NavigationServer2D.map_get_closest_point(get_parent().navRID, positionTarget)
	parent.navigationTarget = positionTarget
	
	#animationName = "stand"
	#get_parent().playAnimation(animationName, true)
	
# Called every frame. 'delta' isD the elapsed time since the previous frame.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):	
	
	get_target()
	parent.angle = parent.global_position.direction_to(parent.navigationAgent.get_next_path_position())
	var targetSpeed = parent.RunSpeed
	#newDir = parent.getAnimDir(parent.angle)
	
	if parent.targetArea.get_overlapping_bodies().size() <=1:
		return idleState
	
	if((positionTarget - parent.global_position).length() < 10):
		get_target()
	
	if parent.getAnimDir(parent.angle) != parent.ActionDir:
		parent.ActionDir = parent.getAnimDir(parent.angle) 
		parent.playAnimation(animationName, carryAnimation)
		
	parent.velocity = lerp(parent.velocity,parent.angle*targetSpeed , parent.lerpFactor /3)
	parent.move_and_slide()
		
	
