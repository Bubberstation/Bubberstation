/datum/orderable_item/mining/survival_bodybag
	purchase_path = /obj/item/bodybag/environmental
	cost_per_order = 500

/datum/orderable_item/mining/suit_voucher
	purchase_path = /obj/item/suit_voucher
	cost_per_order = 2000

/obj/item/kinetic_crusher/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/obj/item/kinetic_crusher/proc/on_reskin(mob/our_mob)
	SIGNAL_HANDLER
	if(icon_state == "crusher_glaive")
		name = "proto-kinetic glaive"
		desc = "A modified proto-kinetic crusher, it is still little more than various mining tools cobbled together \
			into a high-tech knife on a stick with a handguard and goliath-leather grip. While equally as effective as its unmodified compatriots, \
		it still does little to aid any but the most skilled - or suicidal."
		attack_verb_continuous = list("slices", "slashes", "cleaves", "chops", "stabs")
		attack_verb_simple = list("slice", "slash", "cleave", "chop", "stab")
		inhand_x_dimension = 64
		inhand_y_dimension = 64
		our_mob.update_held_items()
