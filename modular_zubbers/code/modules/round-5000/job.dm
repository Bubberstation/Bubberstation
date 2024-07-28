/datum/job
	var/list/abilities

/datum/job/ai
	abilities = list(/datum/action/cooldown/spell/charged/beam/tesla)

/datum/job/atmospheric_technician
	abilities = list(/datum/action/cooldown/spell/conjure/foam_wall/fast,
					/datum/action/cooldown/spell/conjure/extinguisher,
					/datum/action/cooldown/spell/charged/beam/fire_blast)

/datum/job/bartender
	abilities = list(/datum/action/cooldown/spell/pointed/burglar_finesse,
					/datum/action/cooldown/spell/conjure/cheese/drinks
					)

/datum/job/botanist
	abilities = list(/datum/action/cooldown/mob_cooldown/projectile_attack/rapid_fire/seedling,
					/datum/action/cooldown/mob_cooldown/solarbeam)

/datum/job/captain
	abilities = list(/datum/action/cooldown/spell/touch/smite,
					/datum/action/cooldown/spell/voice_of_god)

/datum/job/cargo_gorilla
	abilities = list(/datum/action/cooldown/spell/conjure/simian)

/datum/job/cargo_technician


/datum/job/chemist
	abilities = list(/obj/item/book/granter/action/spell/fireball)

/datum/job/chief_engineer
	abilities = list(/datum/action/cooldown/spell/conjure/foam_wall/fast,
					/datum/action/cooldown/spell/conjure/extinguisher,
					/datum/action/cooldown/spell/conjure/machineframe,
					/datum/action/cooldown/spell/charged/beam/fire_blast)

/datum/job/chief_medical_officer
	abilities = list(/datum/action/cooldown/spell/touch/flesh_surgery)

/datum/outfit/job/cmo
	suit_store = /obj/item/gun/magic/staff/healing/unrestricted

/datum/job/clown
	abilities = list(/datum/action/cooldown/spell/voice_of_god/clown)

/datum/outfit/job/clown
	uniform = /obj/item/clothing/under/rank/civilian/clown/magic
	l_hand = /obj/item/gun/magic/staff/honk

/datum/job/cook
	abilities = list(/datum/action/cooldown/spell/conjure/cheese,
					/datum/action/cooldown/spell/conjure/cheese/food,
					/datum/action/cooldown/spell/pointed/projectile/furious_steel)

/datum/job/coroner
	abilities = list(/datum/action/cooldown/spell/pointed/moon_smile,
					/datum/action/cooldown/spell/aoe/flicker_lights)

/datum/job/curator
	abilities = list(/datum/action/cooldown/mob_cooldown/tentacle_grasp)

/datum/job/cyborg
	abilities = list(/datum/action/cooldown/spell/charged/beam/tesla)

/datum/job/detective
	abilities = list()

/datum/job/doctor
	abilities = list(/datum/action/cooldown/spell/touch/flesh_surgery,
					/datum/action/cooldown/spell/realignment,
					)

/datum/job/geneticist
	abilities = list()

/datum/job/head_of_personnel

/datum/job/head_of_security
	abilities = list(/datum/action/cooldown/mob_cooldown/charge/triple_charge,
					/datum/action/cooldown/spell/teleport/area_teleport,
					/datum/action/cooldown/spell/conjure_item/infinite_guns)

/datum/job/janitor

/datum/job/lawyer

/datum/job/mime
	abilities = list(/datum/action/cooldown/spell/pointed/projectile/finger_guns,
					/datum/action/cooldown/spell/forcewall/mime)

/datum/job/paramedic
	abilities = list(/datum/action/cooldown/mob_cooldown/blood_warp,
					/datum/action/cooldown/spell/teleport/radius_turf/blink)

/datum/job/prisoner
	abilities = list(/datum/action/cooldown/spell/pointed/swap)

/datum/job/psychologist

/datum/job/quartermaster

/datum/job/research_director

/datum/job/roboticist

/datum/job/scientist

/datum/job/security_officer
	abilities = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage)

/datum/job/shaft_miner
	abilities = list(/datum/action/cooldown/spell/rod_form)

/datum/job/station_engineer
	abilities = list(/datum/action/cooldown/spell/conjure/machineframe)

/datum/job/warden
	abilities = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/gun,
					/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage)

/datum/job/assistant
	abilities = list(/datum/action/cooldown/spell/aoe/knock)
