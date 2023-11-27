/obj/item/gun/energy/disabler
	name = "disabler mark II"
	desc = "A crowd control weapon that fires strong electrical bolts to force muscle contraction."
	fire_sound_volume = 30

/obj/item/gun/energy/disabler/fire_sounds()
	if(suppressed)
		playsound(src, suppressed_sound, suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, fire_sound, fire_sound_volume, vary_fire_sound)
