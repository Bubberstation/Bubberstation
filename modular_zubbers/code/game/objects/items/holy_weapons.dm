/obj/item/nullrod/papal_staff
	name = "papal staff"
	desc = "A staff used by traditional bishops and popes."
	icon = 'modular_zubbers/icons/obj/items_and_weapons.dmi'
	icon_state = "papal_staff"
	inhand_icon_state = "papal_staff"
	belt_icon_state = "baguette"
	worn_icon_state = "baguette"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("smacks", "strucks", "cracks", "beats", "purifies")
	attack_verb_simple = list("smack", "struck", "crack", "beat", "purify")

/obj/item/clothing/head/mitre
	name = "papal mitre"
	desc = "A traditional headdress, worn by bishops and popes in traditional Christianity"
	icon = 'modular_zubbers/icons/mob/clothing/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/32x48_head.dmi'
	icon_state = "mitre"

/obj/item/clothing/suit/chaplainsuit/armor/papal
	name = "papal robe"
	desc = "A short cape over a cassock, worn by bishops and popes in traditional Christianity"
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	icon_state = "papalrobe"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/storage/box/holy/papal
	name = "Papal Kit"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/papal

/obj/item/storage/box/holy/papal/PopulateContents()
	new /obj/item/clothing/head/mitre(src)
	new /obj/item/clothing/suit/chaplainsuit/armor/papal(src)

///////////////////////////////
//// HYPEREUTACTIC BLADE /////
/////////////////////////////
/obj/item/dualsaber/chaplain
	// Original from Citadel by Sishen1542
	icon = 'modular_zubbers/icons/obj/weapons/1x2.dmi'
	icon_state = "hypereutactic"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	inhand_icon_state = "hypereutactic"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	name = "divine lightblade"
	desc = "A giant blade of bright and holy light, said to cut down the wicked with ease."
	obj_flags = UNIQUE_RENAME
	slot_flags = ITEM_SLOT_BELT
	item_flags = NO_BLOOD_ON_ITEM | SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	force = 5
	armour_penetration = 0
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	attack_verb_continuous = list("attackes", "slashes", "stabs", "slices", "destroys", "rips", "devastates", "shreds")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "destroy", "rip", "devastate", "shred")
	block_chance = 30
	block_sound = 'modular_zubbers/sound/weapons/nebblock.ogg'
	two_hand_force = 20
	slowdown = 0
	var/chaplain_spawnable = TRUE
	var/menu_description = "A huge energy blade, it possesses the unique ability to block projectiles, but the unwieldy nature of it \
means that you'll be forced to move carefully while it's on. Fits in pockets, and can be worn on the belt when off."
	var/list/cultists_slain

/obj/item/dualsaber/chaplain/Initialize(mapload) //HEAVENLY FATHER I CRAVE COMPONENTS
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_unwielded = force, \
		force_wielded = two_hand_force, \
		wieldsound = 'modular_zubbers/sound/weapons/nebon.ogg', \
		unwieldsound = 'modular_zubbers/sound/weapons/neboff.ogg', \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE,)
	AddComponent(/datum/component/effect_remover, \
		success_feedback = "You disrupt the magic of %THEEFFECT with %THEWEAPON.", \
		success_forcesay = "BEGONE FOUL MAGIKS!!", \
		tip_text = "Clear rune", \
		on_clear_callback = CALLBACK(src, PROC_REF(on_cult_rune_removed)), \
		effects_we_clear = list(/obj/effect/rune, /obj/effect/heretic_rune, /obj/effect/cosmic_rune), \
	)
	AddElement(/datum/element/bane, target_type = /mob/living/basic/revenant, damage_multiplier = 0, added_damage = 25, requires_combat_mode = FALSE)

/obj/item/dualsaber/chaplain/proc/on_cult_rune_removed(obj/effect/target, mob/living/user)
	if(!istype(target, /obj/effect/rune))
		return

/obj/item/dualsaber/chaplain/on_wield()
	.=..()
	slowdown = 1

/obj/item/dualsaber/chaplain/on_unwield()
	.=..()
	slowdown = 0

/obj/item/dualsaber/chaplain/attack(mob/living/target_mob, mob/living/user, params)
	if(!user.mind?.holy_role)
		return ..()
	if(!IS_CULTIST(target_mob) || istype(target_mob, /mob/living/carbon/human/cult_ghost))
		return ..()

	var/old_stat = target_mob.stat
	. = ..()
	if(old_stat < target_mob.stat)
		LAZYOR(cultists_slain, REF(target_mob))
	return .

/obj/item/dualsaber/chaplain/update_icon_state()
	.=..()
	icon_state = inhand_icon_state = "hypereutactic"
	return

/obj/item/dualsaber/chaplain/update_overlays()
	. = ..()
	var/mutable_appearance/blade_overlay = mutable_appearance(icon, "hypereutactic_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance(icon, "hypereutactic_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	. += gem_overlay

	if(HAS_TRAIT(src, TRAIT_WIELDED))
		. += blade_overlay

/obj/item/dualsaber/chaplain/click_alt(mob/user)
	. = ..()
	if(!user.can_perform_action(src, SILENT_ADJACENCY) || hacked)
		return
	if(user.incapacitated() || !istype(user))
		to_chat(user, "<span class='warning'>You can't do that right now!</span>")
		return
	if(alert("Are you sure you want to recolor your blade?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"","Choose Energy Color",light_color) as color|null
		if(!energy_color_input || !user.can_perform_action(src, SILENT_ADJACENCY) || hacked)
			return
		set_light_color(energy_color_input)
		update_icon()
		update_overlays()
	return TRUE

/obj/item/dualsaber/chaplain/process()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		if(hacked)
			set_light_color(light_color)
		open_flame()
	else
		return PROCESS_KILL

/obj/item/dualsaber/chaplain/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(isinhands)
		var/mutable_appearance/gem_inhand = mutable_appearance(icon_file, "hypereutactic_gem")
		gem_inhand.color = light_color
		. += gem_inhand
		if(HAS_TRAIT(src, TRAIT_WIELDED))
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "hypereutactic_blade")
			blade_inhand.color = light_color
			. += blade_inhand

/obj/item/dualsaber/chaplain/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to recolor it.</span>"
	if (!IS_CULTIST(user) || !GET_ATOM_BLOOD_DNA_LENGTH(src))
		return

	var/num_slain = LAZYLEN(cultists_slain)
	. += span_cult_italic("It has the blood of [num_slain] fallen cultist[num_slain == 1 ? "" : "s"] on it. \
		<b>Offering</b> it to Nar'sie will transform it into a [num_slain >= 3 ? "powerful" : "standard"] cult weapon.")
