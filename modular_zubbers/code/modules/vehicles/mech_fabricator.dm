/obj/machinery/mecha_part_fabricator/interdyne
	name="Syndicate Branded Exosuit Fabricator"
	link_on_init = FALSE
	circuit=/obj/machinery/mecha_part_fabricator/interdyne

/obj/machinery/mecha_part_fabricator/interdyne/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	if(ROLE_SYNDICATE in user.faction)
		obj_flags |= EMAGGED
		for(var/found_illegal_mech_nods in SSresearch.techweb_nodes)
			var/datum/techweb_node/illegal_mech_node = SSresearch.techweb_nodes[found_illegal_mech_nods]
			if(!illegal_mech_node?.illegal_mech_node)
				continue
			for(var/id in illegal_mech_node.design_ids)
				var/datum/design/illegal_mech_design = SSresearch.techweb_design_by_id(id)
				illegal_local_designs |= illegal_mech_design
				cached_designs |= illegal_mech_design
		say("R$c!i&ed ERROR de#i$ns. C@n%ec$%ng to ~NULL~ se%ve$s.")
		playsound(src, 'sound/machines/uplinkerror.ogg', 50, TRUE)
		update_static_data_for_all_viewers()
		return TRUE
	else
		to_chat(user, span_warning("You try clicking and typing but don’t understand what to do with it"))
		return FALSE

/obj/item/circuitboard/machine/mechfab/interdyne
	name = "Syndicate Exosuit Fabricator"
	build_path = /obj/machinery/mecha_part_fabricator/interdyne

