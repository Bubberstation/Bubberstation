//Modsuits used by offstation syndicate factions

//Infiltrator mod minus the Psi Emitter

/datum/mod_theme/infiltrator/persistence
	extended_desc = "Several questions have been raised over the years in regards to the clandestine Infiltrator modular suit. \
		Why is the suit blood red despite being a sneaking suit? Why did a movie company of all things develop a stealth suit? \
		The simplest answer is that Roseus Galactic hire more than a few eccentric individuals who know more about \
		visual aesthetics and prop design than they do functional operative camouflage. But the true reason goes deeper. \
		The visual appearance of the suit exemplifies brazen displays of power, not true stealth. However, the suit's inbuilt stealth mechanisms\
		prevent anyone from fully recognizing the occupant, only the suit, creating perfect anonymity. \
		This one seems to lack the Psi Emitter usually seen in this type of modsuit."

	inbuilt_modules = list(/obj/item/mod/module/infiltrator, /obj/item/mod/module/storage/belt)
	allowed_suit_storage = list(
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/energy/sword,
		/obj/item/shield/energy,
	)
