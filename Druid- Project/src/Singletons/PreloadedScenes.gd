extends Node

onready var PROJECTILES = {
	"red"				:	preload("res://src/Projectiles/RedProjectile.tscn"),
	"blue"				:	preload("res://src/Projectiles/BlueProjectile.tscn"),
	"green"				:	preload("res://src/Projectiles/GreenProjectile.tscn"),
	"neutral"			:	preload("res://src/Projectiles/NeutralProjectile.tscn")
}

onready var EFFECTS = {
	"hit"				:	preload("res://src/Animated Effects/HitEffect.tscn"),
	"dust"				:	preload("res://src/Animated Effects/DustEffect.tscn"),
	"poof"				:	preload("res://src/Animated Effects/PoofEffect.tscn"),
	"fissure collapse"	:	preload("res://src/Animated Effects/FissureCollapse.tscn"),
	"blast"				:	preload("res://src/Animated Effects/BlastEffect.tscn")
}
