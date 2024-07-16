extends Character

@onready var actionLocks: AnimationPlayer = $actionLocks

func showSprite(sprite):
	super(sprite)

func hideSprite(sprite):
	super(sprite)

func playAnimation(animation, carry):
	super(animation, carry)
	
func getAnimDir(vec):
	return(super(vec))
	
func _ready():
	atackRange = 0.3
	maxHealth = 50
	health = 50
	Speed = 0
	baseDamage = 5
	strength = 20
	super()
	
func _physics_process(delta):
	super(delta)

func _on_animation_player_animation_finished(anim_name):
	super(anim_name)
	
func checkAtack():
	get_node("atack").checkAtack()
