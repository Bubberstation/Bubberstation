// Core code edits

// Extra Inventory stuff
/datum/sprite_accessory/underwear
	/// Briefs object to which the accessory is linked
	var/obj/item/clothing/underwear/briefs/briefs_obj
	/// If it's generated from a briefs object
	var/from_object = FALSE

/datum/sprite_accessory/undershirt
	/// Shirt object to which the accessory is linked
	var/obj/item/clothing/underwear/shirt/shirt_obj
	/// If it's generated from a shirt object
	var/from_object = FALSE

/datum/sprite_accessory/bra
	/// Bra object to which the accessory is linked
	var/obj/item/clothing/underwear/shirt/bra/bra_obj
	/// If it's generated from a bra object
	var/from_object = FALSE

/datum/sprite_accessory/socks
	/// Socks object to which the accessory is linked
	var/obj/item/clothing/underwear/socks/socks_obj
	/// If it's generated from a socks object
	var/from_object = FALSE
