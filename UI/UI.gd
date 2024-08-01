extends CanvasLayer

var lifePercentage = 1.0

@onready var timeLabel : Label = $timeLabel
@onready var scoreLabel : Label = $scorePanel/scoreLabel
@onready var lifeBar : ProgressBar = $lifePanel/lifeBar
# Called when the node enters the scene tree for the first time.
func _ready():
	gameManager.UI = self # Replace with function body.
	#gameManager.player.heartCollected.connect(on_heart_collected) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timeLabel.text = "%02d:%02d" % [gameManager.minutes, gameManager.seconds]
	
	scoreLabel.text = "%01d" % [gameManager.playerScore]
	#lifeBar.value = int((float(gameManager.player.health) / float(gameManager.player.maxHealth)) * 100)
	
func UIUpdate():
	lifeBar.value = int((float(gameManager.player.health) / float(gameManager.player.maxHealth)) * 100)
