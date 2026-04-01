/datum/bloodsucker_clan/tremere
	name = CLAN_TREMERE
	description = "The Tremere Clan is extremely weak to True Faith, and will burn when entering areas considered such, like the Chapel. \n\
		Additionally, a whole new moveset is learned, built on Blood magic rather than Blood abilities, which are upgraded overtime. \n\
		More ranks can be gained by Ghoulizing crewmembers. \n\
		The Favorite Ghoul gains the Batform spell, being able to morph themselves at will."
	clan_objective = /datum/objective/bloodsucker/tremere_power
	join_icon_state = "tremere"
	join_description = "You will burn if you enter the Chapel, lose all default powers, \
		but gain Blood Magic instead, stronger powers you level up overtime."
	buy_power_flags = TREMERE_CAN_BUY|CAN_BUY_OWNED

/datum/bloodsucker_clan/tremere/New(mob/living/carbon/user)
	. = ..()
	bloodsuckerdatum.remove_nondefault_powers(return_levels = TRUE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.all_bloodsucker_powers)
		if((initial(power.purchase_flags) & buy_power_flags) && initial(power.level_current) == 1)
			bloodsuckerdatum.BuyPower(power)

/datum/bloodsucker_clan/tremere/Destroy(force)
	for(var/datum/action/cooldown/bloodsucker/power in bloodsuckerdatum.powers)
		if(power.purchase_flags & buy_power_flags)
			bloodsuckerdatum.RemovePower(power)
	return ..()

/datum/bloodsucker_clan/tremere/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	. = ..()
	var/area/current_area = get_area(bloodsuckerdatum.owner.current)
	if(istype(current_area, /area/station/service/chapel))
		to_chat(bloodsuckerdatum.owner.current, span_warning("You don't belong in holy areas! The Faith burns you!"))
		bloodsuckerdatum.owner.current.adjust_fire_loss(10)
		bloodsuckerdatum.owner.current.adjust_fire_stacks(2)
		bloodsuckerdatum.owner.current.ignite_mob()

/datum/bloodsucker_clan/tremere/level_up_powers(datum/antagonist/bloodsucker/source)
	return

/datum/bloodsucker_clan/tremere/level_message(power_name)
	var/mob/living/carbon/human/human_user = bloodsuckerdatum.owner.current
	human_user.balloon_alert(human_user, "upgraded [power_name]!")
	to_chat(human_user, span_notice("You have upgraded [power_name]!"))

// redefine the default args
/datum/bloodsucker_clan/tremere/list_available_powers(already_known, powers_list)
	already_known = list()
	powers_list = bloodsuckerdatum.powers
	return ..()

/datum/bloodsucker_clan/tremere/purchase_choice(datum/antagonist/bloodsucker/source, datum/action/cooldown/bloodsucker/purchased_power)
	return purchased_power.upgrade_power()

/datum/bloodsucker_clan/tremere/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/datum/action/cooldown/spell/shapeshift/bat/batform = new(ghouldatum.owner || ghouldatum.owner.current)
	batform.Grant(ghouldatum.owner.current)

/datum/bloodsucker_clan/tremere/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/datum/action/cooldown/spell/shapeshift/bat/batform = locate() in ghouldatum.owner.current.actions
	batform.Remove(ghouldatum.owner.current)

/datum/bloodsucker_clan/tremere/on_ghoul_made(datum/antagonist/bloodsucker/source, mob/living/user, mob/living/target)
	. = ..()
	to_chat(bloodsuckerdatum.owner.current, span_danger("You have now gained an additional Rank to spend!"))
	bloodsuckerdatum.AdjustUnspentRank(1)
