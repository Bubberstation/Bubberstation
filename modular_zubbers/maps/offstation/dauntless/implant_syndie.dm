/obj/item/implant/interdyne
	name = "syndicate IFF implant"
	desc = "Welcome to the syndicate."
	actions_types = null

/obj/item/implant/interdyne/get_data()
	return "<b>Implant Specifications:</b><BR> \
		<b>Name:</b> Syndicate IFF system Implant<BR> \
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
	name = "implanter (syndicate IFF)"
	imp_type = /obj/item/implant/interdyne

/obj/item/implantcase/interdyne
	name = "implant case - 'Syndicate Identification Friend or Foe'"
	desc = "A glass case containing an IFF system implant manufactured by Interdyne Pharmaceutics. These do not work with the IFF systems used by the Gorlex Marauders. Are you ready to join the Syndicate, agent?"
	imp_type = /obj/item/implant/interdyne

