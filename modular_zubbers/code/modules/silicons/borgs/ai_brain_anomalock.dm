/obj/item/organ/brain/cybernetic/ai/anomalock
	name = "Cybernetic-Interface AI-uplink brain"
	//---- Anomaly core variables:
	/// The core items the brain runs off.
	var/list/inserted_cores = list()
	/// Accepted types typecache of anomaly cores.
	var/static/list/required_cores = typecacheof(list(
		/obj/item/assembly/signaler/anomaly/flux,
		/obj/item/assembly/signaler/anomaly/hallucination,
		/obj/item/assembly/signaler/anomaly/bioscrambler
		))
	/// If the core is removable once socketed.
	var/core_removable = TRUE

/// Checks if the brain has all the inserted cores required. Has the option to take an anomaly as an input to check if we have that type of anomaly already inserted. Otherwise it checks if the brain has all the required cores.
/obj/item/organ/brain/cybernetic/ai/anomalock/proc/check_inserted_cores(obj/item/assembly/signaler/anomaly/A)
	if(A)
		if(is_type_in_list(A, inserted_cores))
			return FALSE
		return TRUE

	return (inserted_cores.len == required_cores.len)

/obj/item/organ/brain/cybernetic/ai/anomalock/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(!check_inserted_cores())
		return FALSE
	playsound(organ_owner, 'sound/items/eshield_recharge.ogg', 40)

/obj/item/organ/brain/cybernetic/ai/anomalock/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!is_type_in_list(tool, required_cores))
		return NONE
	var/obj/item/assembly/signaler/anomaly/core = tool
	if(!check_inserted_cores(core))
		balloon_alert(user, "[core] already in!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	inserted_cores += core
	balloon_alert(user, "[core] installed")
	playsound(src, 'sound/machines/click.ogg', 30, TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/organ/brain/cybernetic/ai/anomalock/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(inserted_cores.len <= 0)
		balloon_alert(user, "no cores installed!")
		return
	if(!core_removable)
		balloon_alert(user, "can't remove cores!")
		return
	if(!do_after(user, 3 SECONDS, target = src))
		balloon_alert(user, "interrupted!")
		return
	balloon_alert(user, "cores removed")
	for(var/obj/item/assembly/signaler/anomaly/core in inserted_cores)
		core.forceMove(drop_location())
	inserted_cores = list()
	playsound(src, 'sound/machines/click.ogg', 30, TRUE)

/obj/item/organ/brain/cybernetic/ai/anomalock/examine(mob/user)
	. = ..()
	. += "It has [inserted_cores.len] cores inserted.\n"
	for(var/atom/core as anything in required_cores)
		if(is_path_in_list(core, inserted_cores))
			. += "A [initial(core.name)] is inserted!"
		else
			. += span_warning("It is missing a <b>[initial(core.name)]</b>.")
