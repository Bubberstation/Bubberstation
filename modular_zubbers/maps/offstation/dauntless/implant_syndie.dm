/obj/item/implant/interdyne
	name = "interdyne implant"
	desc = "Welcome to Interdyne Pharmaceutics."
	actions_types = null

/obj/item/implant/interdyne/get_data()
	return "<b>Implant Specifications:</b><BR> \
		<b>Name:</b> Interdyne Pharmaceutics Employee Implant<BR> \
		<b>Implant Details:</b> This implant will install a bio-metric signature that will ensure they are not targeted by lethal security devices.<BR>"

/obj/item/implant/interdyne/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	var/mob/living/living_target = target
	var/obj/item/implant/weapons_auth/weapons_authorisation = new/obj/item/implant/weapons_auth(living_target)
	weapons_authorisation.implant(living_target)
	living_target.faction |= ROLE_SYNDICATE
	return TRUE

/obj/item/implant/interdyne/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	var/mob/living/living_target = target
	var/obj/item/implant/weapons_auth/weapons_authorisation = new/obj/item/implant/weapons_auth(living_target)
	weapons_authorisation.removed(living_target)
	living_target.faction &= ROLE_SYNDICATE
	return TRUE

/obj/item/implanter/interdyne
	name = "implanter (interdyne)"
	imp_type = /obj/item/implant/interdyne

/obj/item/implantcase/interdyne
	name = "implant case - 'interdyne'"
	desc = "A glass case containing a Interdyne Pharmaceutics employee implant. Are you ready to join Interdyne Pharmaceutics, agent?"
	imp_type = /obj/item/implant/interdyne
