extends State

@export var atack: State
@export var runAway: State
var NewDir : Vector2

var targetSpace = 250
var target : Vector2 = Vector2(0,0)
var difference : Vector2
var normalDiff : Vector2 



func enter():
	print("ACTION DIR START: ", get_parent().ActionDir)
	print(get_parent())
	super()
	 # Replace with function body.
func exit():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta):	
	if (! target):
		
		target = Vector2(randf_range( -targetSpace, targetSpace), randf_range (-targetSpace, targetSpace))
		difference = target - get_parent().position
		normalDiff = difference.normalized()
		
		get_parent().Speed = 200
		get_parent().hideSprite("stand")
		get_parent().showSprite("run")
		animationName = "run"
		
		if get_parent().getAnimDir(normalDiff) != get_parent().ActionDir:
			#print("LOL")
			get_parent().ActionDir = get_parent().getAnimDir(normalDiff) 
			get_parent().playAnimation(animationName, true)
		
	
	else:
		
		var direction = Vector2.ZERO
		direction = get_parent().navigationAgent.get_next_path_position() - get_parent().global_position
		direction = direction.normalized()
		get_parent().velocity = direction * 140
	#get_parent().velocity = lerp(get_parent().velocity, normalDiff * get_parent().Speed, get_parent().lerpFactor * 1.8)
		get_parent().move_and_slide()
		
		if get_parent().getAnimDir(direction) != get_parent().ActionDir:
			#print("LOL")
			get_parent().ActionDir = get_parent().getAnimDir(direction) 
			get_parent().playAnimation(animationName, true)
		
		if difference.x < 0.5 && difference.y < 0.5:
			target = Vector2(0,0)
	
	#get_parent().velocity = Vector2(40,40)
	#get_parent().velocity = lerp(get_parent().velocity, normalDiff * get_parent().Speed, get_parent().lerpFactor * 1.8)
	
	#get_parent().move_and_slide() 
