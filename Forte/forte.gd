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
	
	#var vec = Vector2(1,0)
	#var rounded 
	#var vec2
	#
	#for x in range(70):
		#rounded = snapped(vec.angle(), 2*PI/2)
		#vec2 = Vector2(1,0).rotated(snapped(vec.angle(), 2*PI/2))
			#
		#print("DEG: ",  rad_to_deg(vec.angle()), "ROUNDED: ", rad_to_deg(vec2.angle()))
		#vec = vec.rotated(0.1)
		#snapped(3.14159, 90)
	
	#var teste = [1, 1, 1, 1, 1]
	#for x in range(teste.size()-1): 
		#print(x, "  LOLOL")
	#var lol = [1,2,3]
	#print("lol: ", lol)
	#lol.push_back(lol[0])
	#print("LOL: ", lol)
	#
	#lol.insert(2, lol.pop_at(3))
	#print("uwu: ", lol)
	
	#var lol = [3, 7, 1, 9, 2, 15, 8, 1, 67, 2, 35, 3, 35, 3, 6, 76, 46]
	#print("ANTES: ", lol)
	#for x in range(1, lol.size()-1):
		#var smallest = 100
		#var angle = 0
		#for y in range(x , lol.size()):
			#angle = lol[y]
			#if angle <= smallest:
				#smallest = angle
				#lol.insert(x, lol.pop_at(y))
				#
	#print("DEPOIS: ", lol)
	gameManager.player = self
	atackRange = 0.3
	maxHealth = 50
	health = 50
	Speed = 0
	baseDamage = 5
	strength = 20
	super()
	
func heal(amount):
	super(amount)
	gameManager.UIUpdate()

func _physics_process(delta):
	super(delta)

func _on_animation_player_animation_finished(anim_name):
	super(anim_name)
	
func checkAtack():
	get_node("atack").checkAtack()

signal heartCollected(value: int)
	
