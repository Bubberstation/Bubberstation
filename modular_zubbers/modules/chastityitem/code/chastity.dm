/obj/item/clothing/sextoy/chastity
	name = "DEBUG ITEM"
	desc = "call an admin probably"
	icon = 'modular_zubbers/modules/chastityitem/obj/lewd_chastity.dmi'
	lefthand_file = 'modular_zubbers/modules/chastityitem/mob/chastity_inhands/lewd_chastity_inhand_left.dmi'
	righthand_file = 'modular_zubbers/modules/chastityitem/mob/chastity_inhands/lewd_chastity_inhand_right.dmi'
	worn_icon = 'modular_zubbers/modules/chastityitem/mob/chastity_clothing/lewd_chastity.dmi'
	interaction_flags_click = NEED_DEXTERITY
	alternate_worn_layer = UNDER_SUIT_LAYER
	clothing_flags = INEDIBLE_CLOTHING
	var/locked = FALSE
	var/broken = FALSE
	var/electronic = FALSE
	var/devicetype = null

/obj/item/clothing/sextoy/chastity/remote
	var/random = TRUE
	var/freq_in_name = TRUE
	var/code = 2
	var/frequency = FREQ_ELECTROPACK


/obj/item/clothing/sextoy/chastity/belt
	name = "chastity belt"
	desc = "They say codpieces are back in vogue, after all."
	devicetype = "belt"
	icon_state = "chastitybelt"
	inhand_icon_state = "chastitybelt"
	worn_icon_state = "chastitybelt"
	w_class = WEIGHT_CLASS_SMALL
	lewd_slot_flags = LEWD_SLOT_PENIS | LEWD_SLOT_VAGINA

/obj/item/clothing/sextoy/chastity/cage
	name = "chastity cage"
	desc = "They say codpieces are back in vogue, after all."
	devicetype = "cage"
	icon_state = "chastitycage"
	inhand_icon_state = "chastitycage"
	worn_icon_state = "chastitycage"
	w_class = WEIGHT_CLASS_SMALL
	lewd_slot_flags = LEWD_SLOT_PENIS

obj/item/clothing/sextoy/chastity/belt/remote
	name = "remote chastity belt"
	desc = "They say codpieces are back in vogue, after all."
	devicetype = "belt"
	icon_state = "chastitybelt"
	inhand_icon_state = "chastitybelt"
	worn_icon_state = "chastitybelt"
	w_class = WEIGHT_CLASS_SMALL
	lewd_slot_flags = LEWD_SLOT_PENIS | LEWD_SLOT_VAGINA

/obj/item/clothing/sextoy/chastity/cage/remote
	name = "remote chastity cage"
	desc = "They say codpieces are back in vogue, after all."
	devicetype = "cage"
	icon_state = "chastitycage"
	inhand_icon_state = "chastitycage"
	worn_icon_state = "chastitycage"
	w_class = WEIGHT_CLASS_SMALL
	lewd_slot_flags = LEWD_SLOT_PENIS
	
/obj/item/clothing/sextoy/chastity/remote/Initialize(mapload)
	if(random)
		code = rand(1, 100)
		frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))
			frequency++
	if(freq_in_name)
		name = initial(name) + " - freq: [frequency/10] code: [code]"
	set_frequency(frequency)
	. = ..()

/obj/item/clothing/sextoy/chastity/remote/Destroy()
	SSradio.remove_object(src, frequency)
	. = ..()
	
/obj/item/clothing/sextoy/chastity/remote/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	SSradio.add_object(src, frequency, RADIO_SIGNALER)
	
/obj/item/clothing/sextoy/chastity/remote/ui_state(mob/user)
	return GLOB.hands_state


/obj/item/clothing/sextoy/chastity/cage/attack_self(mob/user)
	if(electronic)
		
	keyname = stripped_input(user, "Would you like to change the name on the key?", "Renaming key", "Key", MAX_NAME_LEN)
	name = "[initial(name)] - [keyname]"

/obj/item/clothing/sextoy/chastity/examine(mob/user)
	. = ..()

		. += "It seems to be [locked ? "locked" : "unlocked"]."

/obj/item/clothing/sextoy/chastity/proc/IsLocked(to_lock, mob/user)
	if(!broken)
		to_chat(user, span_warning("The [devicetype] is [to_lock ? "bolted tight." : "unbolted."]"))
		locked = (to_lock ? TRUE : FALSE)
		if(!to_lock)
			REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_NODROP)
		return
	to_chat(user, span_warning("You've carved out the bolting pin - Let's hope whoever made you wear this doesn't find out."))
	locked = FALSE
	REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_NODROP)

/obj/item/clothing/sextoy/chastity/attackby(obj/item/key/chastity/attack_item, mob/user, params)
	if(!istype(attack_item))
		return
	if(attack_item.key_id == REF(src))
		IsLocked((locked ? FALSE : TRUE), user)
		return
	to_chat(user, span_warning("This isn't the correct key!"))

// keep it on

/obj/item/clothing/sextoy/chastity/attack_hand(mob/user)
	if(loc == user && is_inside_lewd_slot(user) && locked)
		to_chat(user, span_warning("The [devicetype] is locked! You'll need to unlock it before you can take it off!"))
		return
	add_fingerprint(usr)
	return ..()

/obj/item/clothing/sextoy/chastity/mouse_drop_dragged(atom/over_object, mob/user, src_location, over_location, params)
	if(loc == user && is_inside_lewd_slot(user) && locked && istype(over_object, /atom/movable/screen/inventory/hand))
		to_chat(user, span_warning("The [devicetype] is locked! You'll need to unlock it before you can take it off!"))
		return
	var/atom/movable/screen/inventory/hand/inv_hand = over_object
	if(user.putItemFromInventoryInHandIfPossible(src, inv_hand.held_index))
		add_fingerprint(user)
	return ..()
	
/obj/item/clothing/sextoy/chastity/equipped(mob/user, slot)
	var/mob/living/carbon/human/chasted = user
	
	if(ishuman(user))
		if(broken)
			to_chat(user, span_warning("The [devicetype] is broken - how did you expect to put it on?"))
			return
		if(locked)
			to_chat(user, span_warning("The [devicetype] is bolted. Unbolt it first."))
			return

		chasted.add_overlay(chasted.overlays_standing[BODY_ADJ_LAYER])
		
		chasted.regenerate_icons()
	. = ..()

/obj/item/clothing/sextoy/chastity/dropped(mob/user)
	var/mob/living/carbon/human/chasted = user
	if(ishuman(user))
		chasted.cut_overlay(chasted.overlays_standing[BODY_ADJ_LAYER])
	. = ..()
	
/obj/item/key/chastity/attack_self(mob/user)
	keyname = stripped_input(user, "Would you like to change the name on the key?", "Renaming key", "Key", MAX_NAME_LEN)
	name = "[initial(name)] - [keyname]"
	
//checks for the key's ID
/obj/item/key/chastity/attack(mob/living/carbon/human/target, mob/living/user, params)
	if(!istype(target))
		return
	. = ..()
	if(!istype(target.wear_vagina | target.wear_penis, /obj/item/clothing/neck/kink_collar/locked))
		return
	var/obj/item/clothing/neck/kink_collar/locked/collar = target.wear_neck
	if(REF(collar) == src.key_id)
		collar.IsLocked((collar.locked ? FALSE : TRUE), user)
	else
		to_chat(user, span_warning("This isn't the correct key!"))

/obj/item/circular_saw/attack(mob/living/carbon/target, mob/living/user, params)
	if(!istype(target))
		return ..()
	if(!istype(target.wear_neck, /obj/item/clothing/neck/kink_collar/locked))
		return ..()
	var/obj/item/clothing/neck/kink_collar/locked/collar = target.wear_neck
	if(collar.broken)
		to_chat(user, span_warning("The lock is already broken!"))
		return
	to_chat(user, span_warning("You try to cut the lock right off!"))
	if(target != user)
		if(!do_after(user, 2 SECONDS, target))
			return
		collar.broken = TRUE
		collar.IsLocked(FALSE, user)
		if(prob(33)) //chance to get damage
			to_chat(user, span_warning("You successfully cut away the lock, but gave [target.name] several cuts in the process!"))
			target.apply_damage(rand(1, 4), BRUTE, BODY_ZONE_HEAD, wound_bonus = 10)
		else
			to_chat(user, span_warning("You successfully cut away the lock!"))
	else
		if(!do_after(user, 3 SECONDS, target))
			return
		if(prob(33))
			to_chat(user, span_warning("You successfully cut away the lock, but gave yourself several cuts in the process!"))
			collar.broken = TRUE
			collar.IsLocked(FALSE, user)
			target.apply_damage(rand(2, 4), BRUTE, BODY_ZONE_HEAD, wound_bonus = 10)
		else
			to_chat(user, span_warning("You fail to cut away the lock, cutting yourself in the process!"))
			target.apply_damage(rand(3, 5), BRUTE, BODY_ZONE_HEAD, wound_bonus = 30)


/obj/item/key/chastity
	name = "chastity key"
	desc = "A hex key meant for the bolt on a chastity device. Don't lose this. Or do."
	interaction_flags_click = NEED_DEXTERITY
	var/key_id = null
	var/keyname = null

/obj/item/key/chastity/attack_self(mob/user)
		keyname = stripped_input(user, "Would you like to change the name on the key?", "Renaming key", "Key", MAX_NAME_LEN)
		name = "[initial(name)] - [keyname]"

