extends Node
class_name stateMachine

@export var startingState: State

var currentState: State 
@export var previousState: State

# Called when the node enters the scene tree for the first time.
func init(parent): 
	for child in get_children():
		child.parent = parent
		child.reparent(parent)
		
	changeState(startingState)

func changeState(newState: State):
	#print("NEW STATE: ", State)
	if currentState:
		currentState.exit()
	previousState = currentState
	currentState = newState
	currentState.enter()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta: float):
	var newState = currentState.processPhysics(delta)
	if newState:
		changeState(newState)
		
func processInput(Input):
	var newState = currentState.processInput(Input)
	if newState:
		changeState(newState)
		
func process(delta: float):
	var newState = currentState.process(delta)
	if newState:
		changeState(newState)
