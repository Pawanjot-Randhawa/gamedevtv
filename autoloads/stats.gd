extends Node

#SAW ticks 5 times a second
var SAW_DAMAGE = 8 # 30 DPS
var SAW_DELUXE_DAMAGE = 10 # 50 DPS
var SAW_BULLET_DAMAGE = 8 #DEPENDS ON BULLET SPEED

#BURN ticks twice a second
var BURN_TICK_DAMAGE = 10 #20 DPS for usally 2 seconds so 40
var FLAME_DAMAGE = 12 #52 over 2 seconds
var FLAME_DELUXE_DAMAGE = 20 #60 over 2 seconds, 30 DPS
var FLAMEBULLET_DAMAGE = 30 # 70 over 2 seconds, 35 DPS

#BULLET fire once a second
var BULLET_DAMAGE = 24 # 24 DPS
#DELUXE Bullet spawns 3
var DELUXE_BULLET_DAMAGE = 14 # 42 DPS if you hit all 3 shots

#GAME STATE
var KILLS:int = 0
var ENEMY_COUNT:int = 0
var ENEMY_MAX:int = 5
