/obj/item/organ/brain/lycan
	name = "lupine brain"
	desc = "A larger than average, albeit slightly smoother brain. The hypothalamus seems larger than normal." // I read in a random medical artical that the hypothalamus controls aggression.
	actions_types = list(/datum/action/cooldown/spell/beast_form)
	var/last_slot

/obj/item/organ/brain/lycan/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags)
	. = ..()

	addtimer(CALLBACK(src, PROC_REF(try_getting_slot)), 0.1 SECONDS)

// no remove. we want it to REMEMBER.

/// A delayed getter for the current slot of the mob. Used because theres no easy way to access the client when a mob is spawend...
/obj/item/organ/brain/lycan/proc/try_getting_slot()
	if (last_slot)
		return

	var/client/target_client = owner?.client
	if (!isnull(target_client))
		last_slot = target_client.prefs.savefile.get_entry("default_slot")

/obj/item/organ/brain/lycan/proc/enter_beast_form()
	owner.apply_status_effect(/datum/status_effect/beast_form)

/obj/item/organ/brain/lycan/proc/leave_beast_form()
	owner.remove_status_effect(/datum/status_effect/beast_form)

/obj/item/organ/brain/lycan/proc/toggle_beast_form(mob/user)
	set name = "Enter/Leave Lycan Form"
	set desc = "Succumb to the rage and turn into a lycan."
	set category = "Lycan"

	if(!user)
		return
	if(user.has_status_effect(/datum/status_effect/beast_form))
		leave_beast_form()
	else
		enter_beast_form()
