#define TIME_UNTIL_RESPAWN 30 MINUTES
#define MACHINE_RECHARGE_TIME 15 MINUTES

/*
SO! This is a copy and paste. Normally this is something I wouldn't do, nor would I advise others to do, but this is meant to be a shitty band-aid solution.
I'm doing this because there are gaps in the functionality of the automatic respawner, and I don't want to go through making a PR to Bubber about them. For now at least.
Please do not let this be a permanent solution, it is not designed as such.
*/
/obj/machinery/gs_respawner
	name = "Automatic Respawner"
	desc = "Allows for lost souls to find a new body."
	icon = 'modular_skyrat/modules/mapping/icons/machinery/automatic_respawner.dmi'
	icon_state = "respawner"
	use_power = FALSE //It doesn't make sense for this to require power in most of the use cases.

	/// What is the type of component are we looking for on our ghost before they can respawn? If this is set to FALSE, a component won't be required, please be careful with this.
	var/datum/component/target_component = FALSE
	/// Does our respawner have a cooldown before it can be used again, and if so, how long does it last?
	var/cooldown_time = FALSE
	COOLDOWN_DECLARE(respawn_cooldown)

	/// What is the type of the outfit datum that we want applied to the new body?
	var/datum/outfit/target_outfit = /datum/outfit/job/assistant
	/// What text is shown to the mob that respawned? FALSE will disable anything from being sent.
	var/text_to_show = "Hello there!"
	/// What text is shown to the mob before they decide if they want to respawn or not?
	var/confirmation_text = "Do you wish to use the respawner? If you have a body, you will not be able to return to it."

/obj/machinery/gs_respawner/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(. || !user.mind)
		return FALSE

	if(cooldown_time && !COOLDOWN_FINISHED(src, respawn_cooldown))
		to_chat(user, span_warning("[src] has [COOLDOWN_TIMELEFT(src, respawn_cooldown) / 10] seconds left before it can be used again."))
		return FALSE

	if(!check_if_able_to_respawn(user))
		return FALSE

	var/choice = tgui_alert(user, confirmation_text, name, list("Yes", "No"))
	if(choice != "Yes")
		return FALSE

	var/mob/living/carbon/human/spawned_player = new(user)

	spawned_player.name = user.name
	spawned_player.real_name = user.real_name

	user.client?.prefs.safe_transfer_prefs_to(spawned_player)
	spawned_player.dna.update_dna_identity()

	user.mind.transfer_to(spawned_player, TRUE)
	if(target_outfit)
		spawned_player.equipOutfit(target_outfit)

	spawned_player.forceMove(get_turf(src))
	apply_effects(spawned_player)

	if(text_to_show)
		to_chat(spawned_player, span_boldwarning(text_to_show))

	if(cooldown_time)
		COOLDOWN_START(src, respawn_cooldown, cooldown_time)

/obj/machinery/gs_respawner/proc/check_if_able_to_respawn(mob/dead/observer/user)
	return TRUE

/obj/machinery/gs_respawner/proc/apply_effects(mob/living/carbon/human/spawned_player)
	return TRUE

/obj/machinery/gs_respawner/examine(mob/dead/observer/user)
	. = ..()
	if(cooldown_time)
		if(!COOLDOWN_FINISHED(src, respawn_cooldown))
			. += span_warning("[src] has [COOLDOWN_TIMELEFT(src, respawn_cooldown) / 10] seconds left before it can be used again.")

		else
			. += span_abductor("[src] has a cooldown of [cooldown_time / 10] seconds between uses.")


/obj/machinery/gs_respawner/gato
	name = "GATO Reformation Apparatus"
	desc = "Beats being dead, but don't get used to using this too often. This machine ain't cheap to run."
	confirmation_text = "Do you wish to use this to respawn? Multiple uses of this machine will lead to increasing credit costs. If you are not able to pay, you will be put into debt."
	cooldown_time = MACHINE_RECHARGE_TIME
	text_to_show = null

	var/list/ckey_respawn_usage = list()

/obj/machinery/gs_respawner/gato/check_if_able_to_respawn(mob/dead/observer/user)
	var/time_of_death = user.persistent_client?.time_of_death
	if(!time_of_death)
		return FALSE

	var/respawn_time = time_of_death + TIME_UNTIL_RESPAWN
	if(world.time < respawn_time)
		var/time_delta = respawn_time - world.time
		to_chat(user, span_warning("Not enough time has passed since your death, you have [time_delta / 600] minutes left until you can respawn."))
		return FALSE

	var/choice = tgui_alert(user, "Before you use this, please be sure that nobody is actively trying to resuscitate you.", name, list("I am sure", "I am not sure"))
	if(choice != "I am sure")
		return FALSE

	return TRUE

/obj/machinery/gs_respawner/gato/apply_effects(mob/living/carbon/human/spawned_player)
	var/player_ckey = spawned_player.ckey
	if(!player_ckey)
		return FALSE // They can't pay the toll. :(

	if(!ckey_respawn_usage[player_ckey])
		ckey_respawn_usage[player_ckey] = 1

		to_chat(spawned_player, span_notice("You have used your one free respawn, further uses of this machine will incur a credit fee."))
		return TRUE

	var/datum/mind/player_mind = spawned_player.mind
	if(!istype(player_mind)) // No mind, no luck.
		return FALSE

	var/money_owed = ckey_respawn_usage[player_ckey] * 500
	ckey_respawn_usage[player_ckey] += 1

	var/datum/memory/key/account/player_account_key = player_mind.memories[/datum/memory/key/account]
	if(!istype(player_account_key))
		return FALSE

	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[player_account_key.remembered_id]"]
	if(!istype(account))
		return FALSE

	if(account.has_money(money_owed))
		account.adjust_money(-money_owed, "Reformation Fee")
	else
		account.account_debt = money_owed


	to_chat(spawned_player, span_warning("You have been charged [money_owed]cr for using the reformer. Please be more careful next time."))
	return TRUE


#undef TIME_UNTIL_RESPAWN
#undef MACHINE_RECHARGE_TIME
