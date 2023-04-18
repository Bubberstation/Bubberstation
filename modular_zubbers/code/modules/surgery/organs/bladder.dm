//Bladder: Help with pissing and stuff
//Most bladder code is done in species.dm
/obj/item/organ/internal/bladder
	name = "bladder"
	icon = 'modular_zubbers/icons/obj/medical/organs.dmi'
	icon_state = "bladder"
	desc = "Unlike sharks, you don't use this to float."
	gender = PLURAL
	slot = ORGAN_SLOT_BLADDER
	zone = BODY_ZONE_PRECISE_GROIN
	low_threshold = 25
	high_threshold = 40
	maxHealth = 50
	var/urination_reduction = 0

/obj/item/organ/internal/bladder/proc/get_urination_gain()
	if(damage >= low_threshold)
		if(organ_flags & ORGAN_FAILING)
			return max(2 - urination_reduction, 0)
		return max(1 + (1 * damage/maxHealth) - urination_reduction, 0)
	return max(1 - urination_reduction, 0)
