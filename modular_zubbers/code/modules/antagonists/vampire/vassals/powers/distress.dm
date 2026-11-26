#define DISTRESS_SELF_DAMAGE 10

/datum/action/cooldown/vampire/distress
	name = "Distress"
	desc = "Injure yourself, allowing you to make a desperate call for help to your Master."
	button_icon_state = "power_distress"
	power_explanation = "Use this Power anywhere and your Master will instantly be alerted to your location."
	vampire_power_flags = NONE
	vampire_check_flags = NONE
	check_flags = AB_CHECK_PHASED
	special_flags = NONE
	cooldown_time = 10 SECONDS

/datum/action/cooldown/vampire/distress/get_power_explanation_extended()
	. = list()
	. += "Use this Power anywhere and your Master will instantly be alerted to your location."
	. += "Calling out deals [DISTRESS_SELF_DAMAGE] brute damage to you, and can be done again after [DisplayTimeText(cooldown_time)]."

/datum/action/cooldown/vampire/distress/activate_power()
	. = ..()
	var/datum/antagonist/vassal/vassaldatum = IS_VASSAL(owner)

	owner.balloon_alert(owner, "you call out for your master!")
	if(vassaldatum?.master)
		to_chat(vassaldatum.master.owner, span_userdanger("[owner.real_name], your loyal vassal, is desperately calling for aid at [get_area(owner)]!"))

	var/mob/living/living_owner = owner
	living_owner.adjust_brute_loss(DISTRESS_SELF_DAMAGE)
	deactivate_power()

#undef DISTRESS_SELF_DAMAGE
