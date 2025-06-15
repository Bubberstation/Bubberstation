/mob/living/silicon/robot/doUnEquip(obj/item/item_dropping, force, atom/newloc, no_move, invdrop, silent)
	. = ..()
	if(check_held_item_sprites(item_dropping))
		update_icons()

/mob/living/silicon/robot/put_in_hand(obj/item/item_module, hand_index, forced = FALSE, ignore_anim = TRUE, visuals_only = FALSE)
	. = ..()
	if(check_held_item_sprites(item_module))
		update_icons()

/// contains a list of items that currently have sprites associated with them, and what borg-skin has them, returns true if the held item and borg skin are in the list.
/mob/living/silicon/robot/proc/check_held_item_sprites(obj/item/O)
	var/list/items_with_sprites = list(
		/obj/item/melee/baton/security/loaded = list("dragon-sec"),
		/obj/item/borg/projectile_dampen = list("dragon-pk"),
		/obj/item/katana/ninja_blade = list("dragon-ninja"),
		/obj/item/kinetic_crusher = list("dragon-mining"),
		/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg = list("dragon-mining"),
		/obj/item/melee/energy/sword/cyborg = list("dragon-syndi"),
		/obj/item/gun/energy/laser/cyborg = list("all-sec"),
		/obj/item/gun/energy/e_gun/advtaser/cyborg = list("all-sec"),
		/obj/item/gun/energy/disabler/cyborg = list("all-sec"),
	)
	var/list/item_sprite_data = items_with_sprites[O.type]
	if(item_sprite_data &&  (model.cyborg_base_icon == item_sprite_data[1] || item_sprite_data[1] == "all-sec"))
		return TRUE
	return FALSE
