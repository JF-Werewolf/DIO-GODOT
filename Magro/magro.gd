extends Character

var charTarg: Character

var navigationTarget : Vector2

@onready var actionLocks: AnimationPlayer = $actionLocks

@onready var navigationAgent : NavigationAgent2D = $Navigation/NavigationAgent2D

@onready var navRID : RID  = get_world_2d().get_navigation_map() 

@onready var targetArea : Area2D = $targetArea

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
	
	
func pointEnemies(bodies):
	var root : Node2D = $enemies
	
	for n in root.get_children():
		root.remove_child(n)
		n.queue_free() 
		
	var color = 0.0
	for x in range(bodies.size()-1):
		var line = Line2D.new()
		line.width = 3
		line.add_point(Vector2.ZERO)
		line.add_point(global_position.direction_to(bodies[x].global_position)*30)
		line.default_color = Color(color,color,color,1.0-color/7)
		color += 0.15
		
		root.add_child(line)
		
func sortByAngle(bodies):
	
	if bodies.size()>2:
		var startVec =  global_position.direction_to(bodies[0].global_position)
		#print(startVec)
		
		for x in range(1, bodies.size()-1):
			var smallest = 2 * PI
			var angle = 0
			
			for y in range(x , bodies.size()):
				angle = startVec.angle_to(global_position.direction_to(bodies[y].global_position)) 
				if angle < 0:
					angle = 2 * PI + angle
				if angle <= smallest:
					smallest = angle
					bodies.insert(x, bodies.pop_at(y))
			
	bodies.push_back(bodies[0])
	#pointEnemies(bodies)
	return bodies
	
func pickLargest(bodies):
	var pair = []
	var start = Vector2.ZERO
	var angle = 0
	var largest = 0
	for x in range(bodies.size()-1):
		start = global_position.direction_to(bodies[x].global_position)
		angle = start.angle_to(global_position.direction_to(bodies[x+1].global_position))
		if angle < 0:
			angle = 2 * PI + angle
					
		if angle >= largest:
			largest = angle
			pair = [bodies[x], bodies[x+1]]
			
	return pair
	
func scapeRoute():
	var pair = []
	var angle1
	var angle2
	if targetArea.get_overlapping_bodies().size() > 1:
		var bodies = targetArea.get_overlapping_bodies()
		#pointEnemies(bodies)
		bodies.erase(self)
		#print(bodies)
		bodies = sortByAngle(bodies)
		pair = pickLargest(bodies)
		
		angle1 = global_position.direction_to(pair[0].global_position)
		angle2 = global_position.direction_to(pair[1].global_position)
		
		angle1 = angle1.angle_to(angle2)
		if angle1 <= 0: angle1 += 2*PI
		
		$scape.points[0] = global_position.direction_to(pair[0].global_position).rotated(angle1 /2) * 25 
		#$pair0.points[0] = global_position.direction_to(pair[0].global_position) * 65
		#$pair1.points[0] = global_position.direction_to(pair[1].global_position) * 65
		return global_position.direction_to(pair[0].global_position).rotated(angle1 /2)
			
func _on_animation_player_animation_finished(anim_name):
	super(anim_name)


func _on_timer_timeout():
	scapeRoute()
	#-235,203
	#print("ORIGIN: -235,203 -- CLOSEST: ",  NavigationServer2D.map_get_closest_point(navRID, Vector2(-235.0,203.0)))
	#print(global_position)
	#navigationAgent.target_position = targ.global_position
	navigationAgent.target_position = navigationTarget # Replace with function body.

		
	
