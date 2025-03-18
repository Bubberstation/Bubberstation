/mob/living/silicon/robot/unequip_module_from_slot(obj/item/O)
	..()
	if(check_held_item_sprites(O))
		update_icons()

/mob/living/silicon/robot/equip_module_to_slot(obj/item/O)
	..()
	if(check_held_item_sprites(O))
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
