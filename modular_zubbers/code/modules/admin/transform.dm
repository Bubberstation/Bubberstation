// Stuff that helps the TGUI player panel transform section to work

GLOBAL_LIST_INIT(pp_transformables, list(
	list(
	name = "Common",
	color = "",
	types = list(
		list(
			name = "Human",
			key = /mob/living/carbon/human
			),
		list(
			name = "Monkey",
			key = /mob/living/carbon/human/species/monkey
			),
		list(
			name = "Cyborg",
			key = /mob/living/silicon/robot
			)
		)
	),
	list(
	name = "Xenomorph",
	color = "purple",
	types = list(
		list(
			name = "Larva",
			key = /mob/living/carbon/alien/larva
			),
		list(
			name = "Drone",
			key = /mob/living/carbon/alien/adult/drone
			),
		list(
			name = "Hunter",
			key = /mob/living/carbon/alien/adult/hunter
			),
		list(
			name = "Sentinel",
			key = /mob/living/carbon/alien/adult/sentinel
			),
		list(
			name = "Praetorian",
			key = /mob/living/carbon/alien/adult/royal/praetorian
			),
		list(
			name = "Queen",
			key = /mob/living/carbon/alien/adult/royal/queen
			)
		)
	),
	list(
	name = "Lavaland",
	color = "orange",
	types = list(
		list(
			name = "Goliath",
			key = /mob/living/basic/mining/goliath
			),
		list(
			name = "Legion",
			key = /mob/living/simple_animal/hostile/megafauna/legion/small
			),
		list(
			name = "Blood-Drunk Miner",
			key = /mob/living/simple_animal/hostile/megafauna/blood_drunk_miner
			),
		list(
			name = "Gladiator",
			key = /mob/living/simple_animal/hostile/megafauna/gladiator
			),
		list(
			name = "Dragon",
			key = /mob/living/simple_animal/hostile/megafauna/dragon
			),
		list(
			name = "Legion Hivelord",
			key = /mob/living/simple_animal/hostile/asteroid/elite/legionnaire
			)
		)
	),
	list(
	name = "Cultist",
	color = "violet",
	types = list(
		list(
			name = "Shade",
			key = /mob/living/basic/shade
			),
		list(
			name = "Artificer",
			key = /mob/living/basic/construct/artificer
			),
		list(
			name = "Wraith",
			key = /mob/living/basic/construct/wraith
			),
		list(
			name = "Juggernaut",
			key = /mob/living/basic/construct/juggernaut
			)
		)
	)
))

// selected_mob: Mob to change
// new_type: Path of new type e.g: /mob/living/carbon/alien/humanoid/drone
// new_type_name (optional): Name of the new type (used in logging): e.g: "Drone"
/datum/admins/proc/transform_mob(mob/selected_mob, mob/admin_mob, new_type, new_type_name)
	if(!check_rights(R_SPAWN))
		return

	if(!ismob(selected_mob))
		to_chat(usr, "This can only be used on instances of type /mob.")
		return

	if (!new_type_name)
		new_type_name = new_type

	log_admin("[key_name(usr)] transformed [key_name(selected_mob)] into a [new_type_name].")
	message_admins(span_adminnotice("[key_name_admin(usr)] transformed [key_name_admin(selected_mob)] into a [new_type_name]."))

	var/mob/new_mob = selected_mob.change_mob_type(new_type, delete_old_mob = TRUE)

	if (selected_mob == admin_mob)
		admin_mob = new_mob
	addtimer(CALLBACK(new_mob.mob_panel, PROC_REF(ui_interact), admin_mob), 0.1 SECONDS)
