/obj/effect/mob_spawn/ghost_role/
	/// set this to make the spawner use the outfit.name instead of its name var for things like cryo announcements and ghost records
	/// modifying the actual name during the game will cause issues with the GLOB.mob_spawners associative list
	var/use_outfit_name
	/// Do we use a random appearance for this ghost role?
	var/random_appearance = TRUE
	/// Can we use our loadout for this role?
	var/loadout_enabled = FALSE
	/// Can we use our quirks for this role?
	var/quirks_enabled = FALSE
	/// Are we limited to a certain species type? LISTED TYPE
	var/restricted_species

/obj/effect/mob_spawn/ghost_role/create(mob/mob_possessor, newname, apply_prefs = FALSE)
	//if we can load our own appearance and its not restricted, try

	var/mob/living/carbon/human/spawned_human = ..(mob_possessor, newname, apply_prefs)

	if(!apply_prefs)
		var/datum/language_holder/holder = spawned_human.get_language_holder()
		holder.get_selected_language() //we need this here so a language starts off selected

		return spawned_human

	spawned_human?.client?.prefs?.safe_transfer_prefs_to(spawned_human)
	spawned_human.dna.update_dna_identity()
	if(spawned_human.mind)
		spawned_human.mind.name = spawned_human.real_name // the mind gets initialized with the random name given as a result of the parent create() so we need to readjust it
	spawned_human.dna.species.give_important_for_life(spawned_human) // make sure they get plasmaman/vox internals etc before anything else

	if(quirks_enabled)
		SSquirks.AssignQuirks(spawned_human, spawned_human.client)

	post_transfer_prefs(spawned_human)

	if(loadout_enabled)
		ASYNC // Expensive and not needing to return
			spawned_human.equip_outfit_and_loadout(outfit, spawned_human.client.prefs)
	else
		equip(spawned_human)

	var/obj/machinery/computer/cryopod/control_computer = find_control_computer()

	var/alt_name = get_spawner_outfit_name()
	GLOB.ghost_records.Add(list(list("name" = spawned_human.real_name, "rank" = alt_name ? alt_name : name)))
	if(control_computer)
		control_computer.announce("CRYO_JOIN", spawned_human.real_name, name)

	return spawned_human

/// This edit would cause somewhat ugly diffs, so I'm just replacing it.
/// Original proc in code/modules/mob_spawn/mob_spawn.dm ~line 39.
/obj/effect/mob_spawn/create(mob/mob_possessor, newname, use_loadout = FALSE)
	var/mob/living/spawned_mob = new mob_type(get_turf(src)) //living mobs only
	name_mob(spawned_mob, newname)
	special(spawned_mob, mob_possessor)
	// Only run equip logic if this is NOT a ghost_role spawner, as we already solve equip with loadout there.
	if (!use_loadout)
		equip(spawned_mob)
	spawned_mob_ref = WEAKREF(spawned_mob)
	return spawned_mob

// Anything that can potentially be overwritten by transferring prefs must go in this proc
// This is needed because safe_transfer_prefs_to() can override some things that get set in special() for certain roles, like name replacement
// In those cases, please override this proc as well as special()
// TODO: refactor create() and special() so that this is no longer necessary
/obj/effect/mob_spawn/ghost_role/proc/post_transfer_prefs(mob/living/new_spawn)
	return
