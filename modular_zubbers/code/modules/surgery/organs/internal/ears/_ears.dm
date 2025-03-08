//Copy and paste of monkey's super kitty ears
/obj/item/organ/ears/cat/super
	name = "Super Kitty Ears"
	desc = "A pair of kitty ears that harvest the true energy of cats. Mrow!"
	icon = 'modular_zubbers/icons/obj/clothing/head/costume.dmi'
	icon_state = "superkitty"
	decay_factor = 0
	damage_multiplier = 0.5 // SUPER
	organ_flags = ORGAN_HIDDEN
	/// The instance of kitty form spell given to the user.
	/// The spell will be initialized using the initial typepath.
	var/datum/action/cooldown/spell/shapeshift/kitty/kitty_spell = /datum/action/cooldown/spell/shapeshift/kitty

/obj/item/organ/ears/cat/super/Initialize(mapload)
	if(ispath(kitty_spell))
		kitty_spell = new kitty_spell(src)
	else
		stack_trace("kitty_spell is invalid typepath ([kitty_spell || "null"])")
	return ..()

/obj/item/organ/ears/cat/super/Destroy()
	QDEL_NULL(kitty_spell)
	return ..()

/obj/item/organ/ears/cat/super/attack(mob/target_mob, mob/living/carbon/user, obj/target)
	if(target_mob != user || !implant_on_use(user))
		return ..()

/obj/item/organ/ears/cat/super/attack_self(mob/user, modifiers)
	implant_on_use(user)
	return ..()

/obj/item/organ/ears/cat/super/on_mob_insert(mob/living/carbon/ear_owner)
	. = ..()
	kitty_spell.Grant(ear_owner)

/obj/item/organ/ears/cat/super/on_mob_remove(mob/living/carbon/ear_owner, special = FALSE)
	. = ..()
	kitty_spell.Remove(ear_owner)

// Stole this from demon heart hard, but hey it works
/obj/item/organ/ears/cat/super/proc/implant_on_use(mob/living/carbon/user)
	if(!iscarbon(user) || !user.is_holding(src))
		return FALSE
	user.visible_message(
		span_warning("[user] raises \the [src] to [user.p_their()] head and gently places it on [user.p_their()] head!"),
		span_danger("A strange feline comes over you. You place \the [src] on your head!"),
	)
	playsound(user, 'sound/effects/meow1.ogg', 50, TRUE)

	user.visible_message(
		span_warning("\The [src] melt into [user]'s head!"),
		span_userdanger("Everything is so much louder!"),
	)

	user.temporarilyRemoveItemFromInventory(src, force = TRUE)
	Insert(user)
	return TRUE

// Super syndi kitty ears!
/obj/item/organ/ears/cat/super/syndie
	kitty_spell = /datum/action/cooldown/spell/shapeshift/kitty/syndie
