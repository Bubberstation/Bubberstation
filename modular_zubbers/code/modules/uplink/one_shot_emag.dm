/obj/item/card/emag/one_shot
	name = "cryptographic sequencer"
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_DETECTIVE, JOB_HEAD_OF_SECURITY)
	special_desc = "Upon inspection you can instantly tell this is a real cryptographic sequencer commonly traded in bulk for cheap at countless blackmarkets. They are known for their unreliability and breaking after just one use from their shoddy construction."
	/// How many uses does it have left?
	var/charges = 1
	/// Who summoned this?
	var/caller

/obj/item/card/emag/one_shot/examine(mob/user)
	. = ..()
	if(user == caller)
		. += span_notice("It looks cheapo, they did say it gives just one shot...")
	else
		. += span_notice("It looks flimsy and identical to the \"Donk Co.\" toy.")

/obj/item/card/emag/one_shot/can_emag(atom/target, mob/user)
	if(charges <= 0)
		balloon_alert(user, "unresponsive!")
		return FALSE
	use_charge(user)
	return TRUE

/obj/item/card/emag/one_shot/proc/use_charge(mob/user)
	balloon_alert(user, "out of charges!")
	charges --
