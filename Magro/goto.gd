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
	
	super()
	 # Replace with function body.
func exit():
	super()
	
func processPhysics(delta):	
	
	parent.angle = parent.global_position.direction_to(parent.navigationAgent.get_next_path_position())
	var targetSpeed = parent.RunSpeed
	#newDir = parent.getAnimDir(parent.angle)
	
	if((parent.global_position - parent.navigationTarget).length() < 20):
		return idleState
	
	if parent.getAnimDir(parent.angle) != parent.ActionDir:
		parent.ActionDir = parent.getAnimDir(parent.angle) 
		parent.playAnimation(animationName, carryAnimation)
		
	parent.velocity = lerp(parent.velocity,parent.angle*targetSpeed , parent.lerpFactor /3) * (delta*60)
	parent.move_and_slide()
		
