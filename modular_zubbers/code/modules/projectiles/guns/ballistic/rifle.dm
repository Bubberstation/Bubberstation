/obj/item/gun/ballistic/rifle/rebarxbow
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "rebarxbow"

/obj/item/gun/ballistic/rifle/rebarxbow/syndie
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "rebarxbowsyndie"

/obj/item/ammo_box/magazine/internal/boltaction/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/internal/boltaction/jezail/empty
	start_empty = TRUE

/obj/item/gun/ballistic/rifle/boltaction/donkrifle/empty
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/jezail/empty


/obj/item/gun/ballistic/rifle/boltaction/lionhunterlarp
	name = "antique hunting rifle"
	desc = "This Sahko's clearly seen a lot more love than the average 3SU or even PSC relics that are more often found. One wonders why someone bothered to inlay such fine material over a common rifle, feature a strange, 5 pointed mark, and use such an antiquated optic. We'll never know, but it's in your hands now."
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "lionhunter"
	inhand_icon_state = "lionhunter"
	worn_icon_state = "lionhunter"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/empty

/obj/item/gun/ballistic/rifle/boltaction/lionhunterlarp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)
