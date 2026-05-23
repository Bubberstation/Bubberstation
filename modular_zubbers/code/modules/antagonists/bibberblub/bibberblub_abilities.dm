/datum/action/cooldown/hide //Copy-pasted from the alien larva, but removed a couple alien-specific things. for some reason the alien one didn't work.
	name = "Hide"
	desc = "Allows you to hide beneath tables and certain objects, like some kind of rodent"
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "alien_hide"
	/// The layer we are on while hiding
	var/hide_layer = ABOVE_NORMAL_TURF_LAYER

/datum/action/cooldown/hide/Activate(atom/target)
	if(owner.layer == hide_layer)
		owner.layer = initial(owner.layer)
		owner.visible_message(
			span_notice("[owner] slowly peeks up from the ground..."),
			span_noticealien("You stop hiding."),
		)
		ADD_TRAIT(owner, TRAIT_IGNORE_ELEVATION, ACTION_TRAIT)

	else
		owner.layer = hide_layer
		owner.visible_message(
			span_name("[owner] scurries to the ground!"),
			span_noticealien("You are now hiding."),
		)
		REMOVE_TRAIT(owner, TRAIT_IGNORE_ELEVATION, ACTION_TRAIT)

	return TRUE



// ==== STRUCTURES ====
/datum/action/cooldown/bubberblub_structures
	name = "Build Structure"
	desc = "Build something using nutrients"
	button_icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	button_icon_state = "Bibberblub"
	cooldown_time = 1 SECONDS
	var/mob/living/basic/bibberblub/bibberblub

	var/build_time = 1 SECONDS
	var/obj/structure/structure_to_build
	var/nutriment_cost = 0


/datum/action/cooldown/bubberblub_structures/Grant(mob/granted_to)
	. = ..()
	bibberblub = granted_to
	if(isnull(bibberblub))
		Remove(granted_to)
	name = name + " ([nutriment_cost])"


/datum/action/cooldown/bubberblub_structures/Activate(atom/target)
	. = ..()
	if(bibberblub.nutriment_resource < nutriment_cost)
		bibberblub.balloon_alert(bibberblub, "need more nutriment!")
		return
	if(do_after(bibberblub, build_time, target))
		new structure_to_build(get_turf(bibberblub))
		bibberblub.nutriment_resource -= nutriment_cost

/datum/action/cooldown/bubberblub_structures/slimy_floor
	name = "Build Floor"
	desc = "Cover the floor with goop! Needed to build further structures."
	button_icon_state = "Floor"
	nutriment_cost = 10
	structure_to_build = /obj/structure/bibberblub/slimy_floor

