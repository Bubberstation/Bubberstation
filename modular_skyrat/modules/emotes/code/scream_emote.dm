/datum/emote/living/scream
	vary = TRUE
	mob_type_blacklist_typecache = list(/mob/living/basic/slime, /mob/living/brain)

/datum/emote/living/scream/get_sound(mob/living/user)
	if(issilicon(user))
		var/mob/living/silicon/silicon_user = user
		var/datum/scream_type/selected_scream = silicon_user.selected_scream
		if(isnull(selected_scream))
			return 'modular_skyrat/modules/emotes/sound/voice/scream_silicon.ogg'
		if(user.gender == FEMALE && LAZYLEN(selected_scream.female_screamsounds))
			return pick(selected_scream.female_screamsounds)
		else
			return pick(selected_scream.male_screamsounds)
	if(issilicon(user))
		return 'modular_skyrat/modules/emotes/sound/voice/scream_silicon.ogg'
	if(ismonkey(user))
		return 'modular_skyrat/modules/emotes/sound/voice/scream_monkey.ogg'
	if(istype(user, /mob/living/basic/gorilla))
		return 'sound/mobs/non-humanoids/gorilla/gorilla.ogg'
	if(isalien(user))
		return 'sound/mobs/non-humanoids/hiss/hiss6.ogg'
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if(isnull(human_user.selected_scream) || (LAZYLEN(human_user.selected_scream.male_screamsounds) && LAZYLEN(human_user.selected_scream.female_screamsounds))) //For things that don't have a selected scream(npcs)
		if(prob(1))
			return 'sound/mobs/humanoids/human/scream/wilhelm_scream.ogg'
		return human_user.dna.species.get_scream_sound(human_user)
	if(human_user.gender == FEMALE && LAZYLEN(human_user.selected_scream.female_screamsounds))
		return pick(human_user.selected_scream.female_screamsounds)
	else
		return pick(human_user.selected_scream.male_screamsounds)

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check, intentional)
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user

		if(robot_user.cell?.charge < STANDARD_CELL_CHARGE * 0.2)
			to_chat(robot_user , span_warning("Scream module deactivated. Please recharge."))
			return FALSE
		robot_user.cell.use(STANDARD_CELL_CHARGE * 0.2)
	return ..()
