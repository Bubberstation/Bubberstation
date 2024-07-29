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
	abilities = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/gun)

/datum/job/chemist
	abilities = list(/obj/item/book/granter/action/spell/fireball)

/datum/job/chief_engineer
	abilities = list(/datum/action/cooldown/spell/conjure/foam_wall/fast,
					/datum/action/cooldown/spell/conjure/extinguisher,
					/datum/action/cooldown/spell/conjure/machineframe/advanced,
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
	abilities = list(/datum/action/cooldown/spell/sanguine_strike)

/datum/job/doctor
	abilities = list(/datum/action/cooldown/spell/touch/flesh_surgery,
					/datum/action/cooldown/spell/realignment,
					)

/datum/job/geneticist
	abilities = list(/datum/action/cooldown/spell/apply_mutations/mutate)

/datum/job/head_of_personnel
	abilities = list(/datum/action/cooldown/mob_cooldown/tentacle_grasp,
					/datum/action/cooldown/spell/pointed/projectile/furious_steel,
					/datum/action/cooldown/spell/teleport/area_teleport,
					/datum/action/cooldown/spell/conjure/contract,
					/datum/action/cooldown/spell/forcewall)

/datum/job/head_of_security
	abilities = list(/datum/action/cooldown/mob_cooldown/charge/triple_charge,
					/datum/action/cooldown/spell/teleport/area_teleport,
					/datum/action/cooldown/spell/conjure_item/infinite_guns/hos)

/datum/job/janitor
	abilities = list(/datum/action/cooldown/mob_cooldown/expel_gas/janitor,
					/datum/action/cooldown/mob_cooldown/bot/foam,
					/datum/action/cooldown/spell/conjure/cleaner)

/datum/job/lawyer
	abilities = list(/datum/action/cooldown/spell/conjure/contract,
					/datum/action/cooldown/spell/forcewall) // When you need to build up a good defense for your client

/datum/job/mime
	abilities = list(/datum/action/cooldown/spell/pointed/projectile/finger_guns,
					/datum/action/cooldown/spell/forcewall/mime)

/datum/job/paramedic
	abilities = list(/datum/action/cooldown/mob_cooldown/blood_warp,
					/datum/action/cooldown/spell/teleport/radius_turf/blink)

/datum/job/prisoner
	abilities = list(/datum/action/cooldown/spell/pointed/swap)

/datum/job/psychologist
	abilities = list(/datum/action/cooldown/spell/conjure/cosmic_expansion,
					/datum/action/cooldown/mob_cooldown/guardian_bluespace_beacon,
					)

/datum/job/quartermaster
	abilities = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/gun)

/datum/outfit/job/quartermaster
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/physic_manipulation_tool = 1,
	)

/datum/job/research_director
	abilities = list(/datum/action/cooldown/spell/rod_form,
					/datum/action/cooldown/mob_cooldown/create_legion_turrets,
					/datum/action/cooldown/mob_cooldown/projectile_attack/rapid_fire/netguardian,
					/datum/action/cooldown/mob_cooldown/projectile_attack/rapid_fire)

/datum/job/roboticist
	abilities = list(/datum/action/cooldown/mob_cooldown/projectile_attack/rapid_fire/netguardian,
					/datum/action/cooldown/mob_cooldown/projectile_attack/rapid_fire)

/datum/job/scientist
	abilities = list(/datum/action/cooldown/spell/aoe/repulse,
					/datum/action/cooldown/mob_cooldown/create_legion_turrets)

/datum/job/security_officer
	abilities = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage)

/datum/job/shaft_miner
	abilities = list(/datum/action/cooldown/spell/aoe/repulse,
					/datum/action/cooldown/mob_cooldown/charge)

/datum/job/station_engineer
	abilities = list(/datum/action/cooldown/spell/conjure/machineframe,
					/datum/action/cooldown/spell/charge,
					/datum/action/cooldown/mob_cooldown/projectile_attack/rapid_fire/netguardian)

/datum/job/warden
	abilities = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/gun,
					/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage)

/datum/job/assistant
	abilities = list(/datum/action/cooldown/spell/aoe/knock,
					/datum/action/cooldown/mob_cooldown/charge,)

/datum/job/bitrunner
	abilities = list(/datum/action/cooldown/spell/charge)

/datum/outfit/job/bitrunner
	belt = /obj/item/storage/belt/wands/full



/datum/job/science_guard
	abilities = list(/datum/action/cooldown/spell/aoe/magic_missile/lesser)

/datum/job/orderly
	abilities = list(/datum/action/cooldown/spell/aoe/magic_missile/lesser)

/datum/job/engineering_guard
	abilities = list(/datum/action/cooldown/spell/aoe/magic_missile/lesser)

/datum/job/customs_agent
	abilities = list(/datum/action/cooldown/spell/aoe/magic_missile/lesser)

/datum/job/bouncer
	abilities = list(/datum/action/cooldown/spell/aoe/magic_missile/lesser)

/datum/job/security_medic
	abilities = list(/datum/action/cooldown/spell/stimpack,
					/datum/action/cooldown/mob_cooldown/blood_warp)

/datum/job/chaplain

/datum/outfit/job/blacksmith
	backpack_contents = list(
		/obj/item/forging/hammer = 1,
		/obj/item/forging/tongs = 1,
		/obj/item/forging/billow = 1,
		/obj/item/banhammer/real = 1,
	)
	l_pocket = /obj/item/singularityhammer/pocket

/obj/item/singularityhammer/pocket
	w_class = WEIGHT_CLASS_TINY

/datum/job/corrections_officer

/datum/job/blueshield

/datum/job/nanotrasen_consultant
