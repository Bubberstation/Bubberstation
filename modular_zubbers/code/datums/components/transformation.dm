/** OK THIS IS GOING TO SOUND WEIRD, BUT STAY WITH ME. I'VE PUT A LOT OF THOUGHT ON HOW TO DO THIS WITHOUT FUCKING UP HOW THE GAME CREATES OUR FURRY HOMUNCULUS CREATURES.
 * -----------
 * 	How literally everything else handles any form of transformation (NIF, Changeling, that one lavaland knife I doubt you know about) will mostly dna.copy_dna() from the old to the new.
 * 	But the issue is, literally EVERYTHING fucking breaks the second you're using limbs that are entirely incompatible. (Teshari, synths) and the spaceman that pops out becomes a weird ass frankenstein mess.
 * 	That is, unless you force load one set of prefs to the other mob. (Which is a valid and cool option) But overall, to fix the above issue you HAVE TO change their species.
 * 	This is more an illusionary effect and me tricking the game. The base mob is mostly unaffected. You will look like a synth and still bleed red. How will this work?
 * 	/mob/living/carbon/proc/update_body_parts() detects if the mob has this component, then will create the required icon_render_keys based off a separate entity.
 * 	It can't be the source player directly, cause you chop off their head or they put on a hat, it'll mirror exactly to the component holder which is also undesired jank.
 *  The solution? We still do the whole changeling bullshit to a mob that sits in null space, then have the affected player mirror it.
 * 	If something looks jank, it's because the nullspace dummy we're using for this is not properly mirroring certain icon events. (Hair hiding with hats, gasmasks not clipping with snouts, etc)
 * 	With that, my dear reader, just need to make sure on_transform_limb_icon() properly modifies our nullspace dummy with said event or you add another cached_feature to temporarily change the player's mob.
 *
 * 	TDLR: This whole thing is so you can transform people without changing their species, and for it not to look like shit.
 */

/datum/component/transformation
	/// Source mob that's transferring.
	var/mob/living/carbon/human/original
	/// Dummy human sitting in null space
	var/mob/living/carbon/human/consistent/dummy

	var/list/cached_features = list()
	var/list/cached_limbs = list()

/datum/component/transformation/Initialize(source, id)
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	src.original = source

/datum/component/transformation/RegisterWithParent()
	var/mob/living/carbon/human/owner = parent

	/// Stores everything we need to keep inside a cache.
	cached_features["feature_dna"] += owner.dna.features.Copy()
	cached_features["name"] += owner.real_name
	cached_features["gender"] += owner.gender
	cached_features["bodyshape"] += owner.bodyshape

	/// Now changes everything after we've just shoved it into the closet.

	dummy = new
	original.dna.copy_dna(dummy.dna, COPY_DNA_SE|COPY_DNA_SPECIES|COPY_DNA_MUTATIONS)

	owner.real_name = original.real_name
	owner.name = original.real_name
	owner.gender = original.gender
	owner.bodyshape = original.bodyshape

	owner.dna.features["custom_species"] = original.dna.features["custom_species"]
	owner.dna.features["flavor_text"] = original.dna.features["flavor_text"]
	owner.dna.features["flavor_text_nsfw"] = original.dna.features["flavor_text_nsfw"]
	owner.dna.features["custom_species_lore"] = original.dna.features["custom_species_lore"]

	owner.dna.features["headshot"] = original.dna.features["headshot"]
	owner.dna.features["headshot_nsfw"] = original.dna.features["headshot_nsfw"]
	owner.dna.features["art_ref"] = original.dna.features["art_ref"]

	/// Limb bullshit so worn sprites don't fuck up.
	for(var/zone, untyped_limb in original.get_bodyparts_by_zones())
		var/obj/item/bodypart/originating_limbs = untyped_limb
		var/obj/item/bodypart/dummy_limb = dummy.get_bodypart(zone)
		var/obj/item/bodypart/limb = owner.get_bodypart(zone)

		cached_limbs += list(list("zone" = zone, "limb_id" = limb.limb_id, "bodyshape" = limb.bodyshape))
		limb.limb_id = originating_limbs.limb_id
		limb.bodyshape = originating_limbs.bodyshape
		dummy_limb.limb_gender = originating_limbs.limb_gender

	/// Eyes
	var/obj/item/organ/eyes/owner_eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
	cached_features["eyes"] += list("color_l" = owner.eye_color_left, "color_r" = owner.eye_color_right, "blinking" = owner_eyes.blink_animation)
	owner.set_eye_color(original.eye_color_left, original.eye_color_right)
	owner_eyes.blink_animation = FALSE
	/// Quad eyes
	cached_features["quadeyes"] += HAS_TRAIT_FROM(owner, TRAIT_QUAD_EYES, TRAIT_GENERIC)
	cached_features["quadoffset"] += owner.quad_eyes_offset
	cached_features["quadoffwidth"] += owner.quad_eyes_offset_width
	if(!cached_features["quadeyes"])
		if(HAS_TRAIT_FROM(original, TRAIT_QUAD_EYES, TRAIT_GENERIC))
			ADD_TRAIT(owner, TRAIT_QUAD_EYES, TRAIT_TRANSFORMATION)
	else
		REMOVE_TRAIT(owner, TRAIT_QUAD_EYES, TRAIT_GENERIC)
	owner.quad_eyes_offset = original.quad_eyes_offset
	owner.quad_eyes_offset_width = original.quad_eyes_offset_width

	var/obj/item/bodypart/head/head = original.get_bodypart(BODY_ZONE_HEAD)
	dummy.set_hairstyle(original.hairstyle, FALSE)
	dummy.set_haircolor(original.hair_color)
	dummy.set_facial_hairstyle(original.facial_hairstyle, FALSE)
	dummy.set_facial_haircolor(original.facial_hair_color)
	dummy.set_hair_gradient_style(head.gradient_styles[GRADIENT_HAIR_KEY], FALSE)
	dummy.set_hair_gradient_color(head.gradient_colors[GRADIENT_FACIAL_HAIR_KEY])
	dummy.set_facial_hair_gradient_style(head.gradient_styles[GRADIENT_FACIAL_HAIR_KEY], FALSE)
	dummy.set_facial_hair_gradient_color(head.gradient_colors[GRADIENT_FACIAL_HAIR_KEY])

	owner.regenerate_icons()

/datum/component/transformation/UnregisterFromParent()
	var/mob/living/carbon/human/owner = parent
	/// All the features we stored in cache needs to go back properly.
	owner.dna.features = cached_features["feature_dna"]
	owner.real_name = cached_features["name"]
	owner.name = cached_features["name"]
	owner.gender = cached_features["gender"]
	owner.bodyshape = cached_features["bodyshape"]

	/// Reset our limb bullshit
	for(var/cached in cached_limbs)
		var/zone = cached["zone"]
		var/obj/item/bodypart/limb = owner.get_bodypart(zone)
		limb.limb_id = cached["limb_id"]
		limb.bodyshape = cached["bodyshape"]

	/// Reset our eyes
	var/list/eye_cache = cached_features["eyes"]
	var/obj/item/organ/eyes/owner_eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
	owner.set_eye_color(eye_cache["color_l"], eye_cache["color_r"])
	owner_eyes.blink_animation = eye_cache["blinking"]
	if(!cached_features["quadeyes"] && HAS_TRAIT(owner, TRAIT_QUAD_EYES))
		REMOVE_TRAIT(owner, TRAIT_QUAD_EYES, TRAIT_TRANSFORMATION)
	if(cached_features["quadeyes"])
		ADD_TRAIT(owner, TRAIT_QUAD_EYES, TRAIT_GENERIC)
	owner.quad_eyes_offset = cached_features["quadoffset"]
	owner.quad_eyes_offset_width = cached_features["quadoffwidth"]

	original = null
	QDEL_NULL(dummy)
	owner.regenerate_icons()

/// TODO: Digigrade legs and bodyshape
/datum/component/transformation/proc/on_transform_limb_icon(mob/source) // Easy way to properly reflect icon events.
	var/mob/living/carbon/human/owner = source
	var/list/old_abstractions = dummy.get_equipped_items()
	QDEL_LIST(old_abstractions)
	for(var/obj/item/item in owner.get_equipped_items())
		if(item.slot_flags & (ITEM_SLOT_ICLOTHING|ITEM_SLOT_OCLOTHING|ITEM_SLOT_HEAD|ITEM_SLOT_BACK))
			var/obj/item/abstraction = new item.type
			abstraction.flags_inv = item.flags_inv
			abstraction.equip_to_best_slot(dummy)








