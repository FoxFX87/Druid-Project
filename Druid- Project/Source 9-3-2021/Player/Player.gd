extends Unit

enum STATE {MOVE, PUSH, PREPARE_ATTACK, ATTACK, PLANT}

var inputs = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

var current_state
var move_vector : Vector2 
var push_target : PushObject
var push_vector : Vector2 

onready var sprite = $Sprite
onready var move_ray = $MoveRay
onready var tween = $TweenMove
onready var anim = $AnimationPlayer
