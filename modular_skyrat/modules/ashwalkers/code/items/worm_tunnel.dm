GLOBAL_LIST_EMPTY(ashwalker_tunnels)

/obj/item/tunneling_worm
	name = "ashen tunneling worm"
	desc = "A purple glow seems to radiate from the worm. It slowly gnashes at the ground."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "tunneling_worm"

	/// the amount of uses left
	var/tunnels_remaining = 2

	/// how long it takes to create a tunnel
	var/tunnel_creation = 10 SECONDS

/obj/item/tunneling_worm/examine(mob/user)
	. = ..()
	. += span_notice("<br>Use on the planet's surface to create a tunnel.")
	. += span_notice("[tunnels_remaining] tunnel(s) remaining.")

/obj/item/tunneling_worm/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /turf/open/misc/asteroid/basalt/lava_land_surface)) //eventually we could spread this to more than just lavaland?
		var/turf/interacting_turf = interacting_with
		if(locate(/obj/structure/worm_tunnel) in interacting_turf)
			to_chat(user, span_warning("There is already a tunnel here!"))
			return ITEM_INTERACT_BLOCKING

		var/tunnel_name = tgui_input_text(user, "What would you like to name the tunnel?", "Tunnel Naming (20 Character Max)", max_length = 20)
		if(isnull(tunnel_name))
			to_chat(user, span_warning("You have decided against creating a tunnel!"))
			return ITEM_INTERACT_BLOCKING

		//if we have the primitive skill, perhaps add some functionality to this
		if(!do_after(user, tunnel_creation, target = interacting_turf))
			to_chat(user, span_warning("You have decided against creating a tunnel!"))
			return ITEM_INTERACT_BLOCKING

		var/obj/structure/worm_tunnel/created_tunnel = new /obj/structure/worm_tunnel(interacting_turf)
		created_tunnel.name = tunnel_name
		GLOB.ashwalker_tunnels += created_tunnel
		tunnels_remaining -= 1
		if(tunnels_remaining <= 0)
			to_chat(user, span_warning("[src] has been exhausted!"))
			qdel(src)

		return ITEM_INTERACT_BLOCKING

	return ..()

/obj/structure/worm_tunnel
	name = "worm tunnel"
	desc = "A horrid stench rises from the hole, perhaps the visible bile residue is the cause?"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "worm_tunnel"
	anchored = TRUE
	density = FALSE

	/// whether the tunnel is covered or not
	var/covered_tunnel = FALSE

/obj/structure/worm_tunnel/examine(mob/user)
	. = ..()
	. += span_notice("<br>Using a shovel will destroy the tunnel.")
	. += span_notice("Using two pieces of wood will block the tunnel until removed.")

/obj/structure/worm_tunnel/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/sheet/mineral/wood))
		if(covered_tunnel)
			to_chat(user, span_warning("There is already wood blocking [src]!"))
			return ITEM_INTERACT_BLOCKING

		if(!tool.use(2))
			to_chat(user, span_warning("You are unable to use [tool] to cover [src]!"))
			return ITEM_INTERACT_BLOCKING

		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_notice("You decide against covering [src]."))
			return ITEM_INTERACT_BLOCKING

		covered_tunnel = TRUE
		add_overlay("tunnel_cover")
		return ITEM_INTERACT_BLOCKING

	return ..()

/obj/structure/worm_tunnel/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(covered_tunnel)
		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_notice("You decide against uncovering [src]."))
			return

		var/obj/item/stack/spawning_stack = new /obj/item/stack/sheet/mineral/wood(get_turf(user))
		spawning_stack.amount = 2
		cut_overlay("tunnel_cover")
		return

	var/obj/structure/worm_tunnel/tunnel_choice = tgui_input_list(user, "Which worm tunnel would you travel to?", "Worm Tunnel Choice", GLOB.ashwalker_tunnels)
	if(isnull(tunnel_choice))
		return

	var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(isashwalker(user))
		if(!do_after(user, 10 SECONDS * skill_modifier, target = src))
			to_chat(user, span_notice("You decide against going through [src]."))
			return

	else
		to_chat(user, span_warning("You are attempting to enter [src]! It fights back! Perhaps some persistence will help?"))
		for(var/iterations in 1 to 3)
			if(!do_after(user, 6 SECONDS * skill_modifier, target = src))
				return
			user.adjust_brute_loss(10)

	if(tunnel_choice.covered_tunnel)
		to_chat(user, span_warning("[tunnel_choice] was covered! Returning back to the start!"))
		return

	user.forceMove(get_turf(tunnel_choice))

/obj/structure/worm_tunnel/Destroy(force)
	GLOB.ashwalker_tunnels -= src
	return ..()

/obj/structure/worm_tunnel/shovel_act(mob/living/user, obj/item/tool)
	if(!do_after(user, 10 SECONDS, target = src))
		to_chat(user, span_notice("You decide against filling in [src]."))
		return

	qdel(src)
