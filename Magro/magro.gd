extends Character

var charTarg: Character

var navigationTarget : Vector2

@onready var actionLocks: AnimationPlayer = $actionLocks

@onready var navigationAgent : NavigationAgent2D = $Navigation/NavigationAgent2D

@onready var navRID : RID  = get_world_2d().get_navigation_map() 

func _ready():
	maxHealth = 25
	health = 25
	baseDamage = 3
	strength = 10
	WalkSpeed = 140
	RunSpeed = 220
	super()

func showSprite(sprite):
	super(sprite)

func hideSprite(sprite):
	super(sprite)

func playAnimation(animation, carry):
	super(animation, carry)
	
func getAnimDir(vec):
	return(super(vec))
	
func _physics_process(delta):
	super(delta)

func _on_animation_player_animation_finished(anim_name):
	super(anim_name)


func _on_timer_timeout():
	#-235,203
	#print("ORIGIN: -235,203 -- CLOSEST: ",  NavigationServer2D.map_get_closest_point(navRID, Vector2(-235.0,203.0)))
	#print(global_position)
	#navigationAgent.target_position = targ.global_position
	navigationAgent.target_position = navigationTarget # Replace with function body.

		
	
