extends CanvasLayer

var lifePercentage = 1.0
var timeElapsed = 0.0
var minutes :int = 0

var score = 0

@onready var timeLabel : Label = $timeLabel
@onready var scoreLabel : Label = $scorePanel/scoreLabel
@onready var lifeBar : ProgressBar = $lifePanel/lifeBar
# Called when the node enters the scene tree for the first time.
func _ready():
	gameManager.UI = self # Replace with function body.
	#gameManager.player.heartCollected.connect(on_heart_collected) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeElapsed += delta
	var timeInSeconds = floori(timeElapsed)
	var seconds: int = timeInSeconds % 60
	minutes =  timeInSeconds / 60
	timeLabel.text = "%02d:%02d" % [minutes, seconds]
	
	gameManager.minutes = minutes
	
	scoreLabel.text = "%01d" % [gameManager.playerScore]
	#lifeBar.value = int((float(gameManager.player.health) / float(gameManager.player.maxHealth)) * 100)
	
func UIUpdate():
	lifeBar.value = int((float(gameManager.player.health) / float(gameManager.player.maxHealth)) * 100)
