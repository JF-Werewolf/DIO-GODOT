class_name Character 
extends CharacterBody2D


var maxHealth = 10 
var health = 10
var healthPercentage = 1.0
var Speed = 0
var baseDamage = 3
var strength = 10
var atackRange = 0.3

@export var WalkSpeed = 170
@export var RunSpeed = 260
@export_range(0,1) var lerpFactor = 0.5

var angle = Vector2(0,0)

@export var atacker: Character

@export var atackLock : bool = false
@export var actionLock: bool = false

@export var previousAction = "stand"
#@export var startingAction = "stand" 

@onready var stateM= $stateMachine
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer 
@onready var sprite: Sprite2D 

var test = 0

#@onready var icon = $walkSprite
#@onready var animCon = $AnimationTree
var ActionDir = 3
var PreviousDir = 1

var actionFinished = true
var isJumping = false

func showSprite(sprtName):
	sprite = get_node(sprtName+"Sprite")
	sprite.visible = true

func hideSprite(sprtName):
	sprite = get_node(sprtName+"Sprite")
	sprite.visible = false

func playAnimation(action, carry):
	
	if previousAction != action:
		hideSprite(previousAction)
		showSprite(action)
	
	var AnimPosition = 0.0
	
	if(carry):
		AnimPosition = animationPlayer.current_animation_position
		PreviousDir = ActionDir
		
	animationPlayer.play(action+"_"+str(ActionDir))
	animationPlayer.seek(AnimPosition)
	actionFinished = false
	
	previousAction = action
	#print(animation, " ", actionFinished)
	
func getAnimDir(vec):
	var dir = int(round((vec.angle()) / 0.785398))
	if(dir >= 0): return dir+1
	else: return dir+9
	
func _ready():
	#print(previousAction)
	showSprite(previousAction)
	playAnimation(previousAction, false)
	angle = Vector2(1,0).rotated((ActionDir + 1) * 0.785398)
	
	stateM.init(self)
	
func _physics_process(delta):
	stateM.processPhysics(delta)
	
func takeDamage(foe):
	atacker = foe
	stateM.changeState(get_node("damage"))
	health -= foe.baseDamage 
	healthPercentage = float(health)/float(maxHealth)

func _on_animation_player_animation_finished(_anim_name):
	actionFinished = true 
	#print(actionFinished)
