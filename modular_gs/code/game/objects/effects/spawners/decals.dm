/obj/effect/decal/cleanable/greenglow/radioactive
	name = "radioactive hazard"
	desc = "You should really clean this up..."
	var/rad_pulse_strength = 5
	var/last_event = 0
	var/active = null

/obj/effect/decal/cleanable/greenglow/radioactive/Crossed(atom/movable/O)
	. = ..()
	if(ismob(O))
		radiate()

/obj/effect/decal/cleanable/greenglow/radioactive/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			radiation_pulse(src, rad_pulse_strength)
			for(var/obj/effect/decal/cleanable/greenglow/radioactive/T in orange(1,src))
				T.radiate()
			last_event = world.time
			active = 0
			return

//gato colored signs - from NT blue to GT pink
/obj/structure/sign/warning/gato
	name = "\improper WARNING SIGN"
	desc = "A warning sign which reads 'SECURE AREA'."
	icon = 'GainStation13/icons/obj/decals.dmi'

/obj/structure/sign/warning/gato/securearea
	name = "\improper SECURE AREA"
	desc = "A warning sign which reads 'SECURE AREA'."

/obj/structure/sign/warning/gato/docking
	name = "\improper KEEP CLEAR: DOCKING AREA"
	desc = "A warning sign which reads 'KEEP CLEAR OF DOCKING AREA'."

/obj/structure/sign/warning/gato/biohazard
	name = "\improper BIOHAZARD"
	desc = "A warning sign which reads 'BIOHAZARD'."
	icon_state = "bio"

/obj/structure/sign/warning/gato/electricshock
	name = "\improper HIGH VOLTAGE"
	desc = "A warning sign which reads 'HIGH VOLTAGE'."
	icon_state = "shock"

/obj/structure/sign/warning/gato/vacuum
	name = "\improper HARD VACUUM AHEAD"
	desc = "A warning sign which reads 'HARD VACUUM AHEAD'."
	icon_state = "space"

/obj/structure/sign/warning/gato/vacuum/external
	name = "\improper EXTERNAL AIRLOCK"
	desc = "A warning sign which reads 'EXTERNAL AIRLOCK'."
	layer = MOB_LAYER

/obj/structure/sign/warning/gato/deathsposal
	name = "\improper DISPOSAL: LEADS TO SPACE"
	desc = "A warning sign which reads 'DISPOSAL: LEADS TO SPACE'."
	icon_state = "deathsposal"

/obj/structure/sign/warning/gato/pods
	name = "\improper ESCAPE PODS"
	desc = "A warning sign which reads 'ESCAPE PODS'."
	icon_state = "pods"

/obj/structure/sign/warning/gato/fire
	name = "\improper DANGER: FIRE"
	desc = "A warning sign which reads 'DANGER: FIRE'."
	icon_state = "fire"

/obj/structure/sign/warning/gato/nosmoking
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'."
	icon_state = "nosmoking2"

/obj/structure/sign/warning/gato/nosmoking/circle
	icon_state = "nosmoking"

/obj/structure/sign/warning/gato/radiation
	name = "\improper HAZARDOUS RADIATION"
	desc = "A warning sign alerting the user of potential radiation hazards."
	icon_state = "radiation"

/obj/structure/sign/warning/gato/radiation/rad_area
	name = "\improper RADIOACTIVE AREA"
	desc = "A warning sign which reads 'RADIOACTIVE AREA'."

/obj/structure/sign/warning/gato/enginesafety
	name = "\improper ENGINEERING SAFETY"
	desc = "A sign detailing the various safety protocols when working on-site to ensure a safe shift."
	icon_state = "safety"
