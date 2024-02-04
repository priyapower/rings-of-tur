extends Node2D
## Generic state, from which all other states will inherit ##
class_name State


var change_state
var animation : AnimationPlayer
var sprite : Sprite2D
var persistent_state
var jump_height = 0


"""
This allows the states to have a default _physics_process(delta) 
implementation where velocity is used to move the player. 
The way that the states can modify the movement of the player 
is to use the velocity variable defined in their base class.
"""
func _physics_process(_delta):
	#persistent_state.move_and_slide(persistent_state.jump_height, Vector2.UP)
	persistent_state.move_and_slide()


## Assign references ##
"""
These references will be instantiated in the parent of this state. 
This helps with something in programming known as cohesion. 
The state of the player does not want the responsibility of creating 
these variables, but does want to be able to use them. 
However, this does make the state coupled to the state's parent. 
This means that the state is highly reliant on whether 
it has a parent which contains these variables. 
So, remember that coupling and cohesion are 
important concepts when it comes to code management.
"""
func setup(change_state_function, anim, sprt, persistent):
	self.change_state = change_state_function
	self.animation = anim
	self.sprite = sprt
	self.persistent_state = persistent


## Methods for moving ##
"""
The state script just uses pass to show that it will not execute any 
instructions when the methods are called
"""
func move_left():
	pass


func move_right():
	pass
