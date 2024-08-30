/obj/item/storage/belt/skullhunter
	name = "Skullhunter"
	desc = "An unnerving belt full of skulls. Their eyeless sockets seem to look up at you in contempt."

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	icon_state = "skullhunter"

	worn_icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_worn.dmi'
	worn_icon_state = "skullhunter"

	var/list/stolen_id_names = list() //Assoc list.

/obj/item/storage/belt/skullhunter/examine(mob/user)

	. = ..()

	if(IS_HERETIC(user))
		. += span_velvet("This belt has stolen the access from [length(stolen_id_names)] different crewmembers.")

/obj/item/storage/belt/skullhunter/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_BELT && ishuman(user) && IS_HERETIC(user))
		RegisterSignal(user, COMSIG_HERETIC_BLADE_ATTACK, PROC_REF(on_blade_attack))

/obj/item/storage/belt/skullhunter/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_HERETIC_BLADE_ATTACK)

/obj/item/storage/belt/skullhunter/proc/on_blade_attack(mob/living/source, mob/living/target)

	if(!ishuman(source))
		return

	var/mob/living/carbon/human/source_as_human = source
	var/obj/item/card/id/source_id_card = source_as_human.wear_id?.GetID()

	if(!source_id_card)
		return

	if(!ishuman(target) || !(target.stat & DEAD))
		return

	var/mob/living/carbon/human/target_as_human = target
	var/obj/item/card/id/target_id_card = target_as_human.wear_id?.GetID()

	if(length(stolen_id_names) && stolen_id_names[target_id_card.registered_name])
		return

	if(!target_id_card || !target_id_card.registered_name)
		return

	var/list/access_difference = target_id_card.access - source_id_card.access

	if(!length(access_difference))
		return

	var/list/stolen_access = list(pick(access_difference))

	stolen_id_names[target_id_card.registered_name] = TRUE
	source_id_card.add_access(stolen_access,mode = FORCE_ADD_ALL)

	playsound(get_turf(source),'modular_skyrat/modules/emotes/sound/voice/scream_skeleton.ogg',50,TRUE)

	return





