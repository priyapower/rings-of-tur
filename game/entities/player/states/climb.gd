# Climbing state
extends State

# Input mapping for climb is the same as jump
	# key: Up
	# key: W

# [External files] States that transition to climb
	# These scripts need update (if on_floor && input == crouch: run_crouch)
		# Idle --> climb
		# Run --> climb
		# Jump --> climb

# States that this script handles (transtions from climb)
	# climb --> Idle
