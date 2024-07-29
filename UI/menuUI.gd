extends CanvasLayer

@onready var newGameButton : Panel = $backGround/newGameButton
@onready var newGameText: Label = $backGround/newGameButton/newGame
var onNewGameButton = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("atack"):
		if onNewGameButton:
			print("STARTING GAME")
			gameManager.startGame()
			queue_free()

func _on_new_game_button_mouse_entered():
	newGameText.set("theme_override_colors/font_color",Color(1.0,1.0,1.0)) 
	onNewGameButton = true 

func _on_new_game_button_mouse_exited():
	newGameText.set("theme_override_colors/font_color",Color(0.0,0.0,0.0))
	onNewGameButton = false 

