/obj/projectile/bullet/c9mm/disruptor
	name = "9x25mm disruptor bullet"
	damage = 10
	stamina = 30
	armour_penetration = 15
	jitter = 10 SECONDS
	slur = 10 SECONDS
	embed_type = /datum/embed_data/c9mm_disruptor

/datum/embed_data/c9mm_disruptor
	embed_chance=30
	fall_chance=5
	jostle_chance=4
	ignore_throwspeed_threshold=TRUE
	pain_stam_pct=0.9
	pain_mult=5
	jostle_pain_mult=6
	rip_time=5
