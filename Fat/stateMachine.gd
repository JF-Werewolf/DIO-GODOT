extends stateMachine

func init(parent): 
	super(parent)

func changeState(newState: State):
	#print(newState)
	super(newState)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func processPhysics(delta: float):
	super(delta)
		
func processInput(Input):
	super(Input)
		
func process(delta: float):
	super(delta) 
