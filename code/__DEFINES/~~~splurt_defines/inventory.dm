//Underwear and extra slots
/// Slot to indicate it's an extra slot
#define ITEM_SLOT_EXTRA (1<<23) //this will work until TG decides to use this value for a slot for some reason
/// Underwear slot
#define ITEM_SLOT_UNDERWEAR ITEM_SLOT_EXTRA | (1<<0)
/// Socks slot
#define ITEM_SLOT_SOCKS ITEM_SLOT_EXTRA | (1<<1)
/// Shirt slot
#define ITEM_SLOT_SHIRT ITEM_SLOT_EXTRA | (1<<2)
/// Bra slot
#define ITEM_SLOT_BRA ITEM_SLOT_EXTRA | (1<<3)
/// Right ear slot
#define ITEM_SLOT_EARS_RIGHT ITEM_SLOT_EXTRA | (1<<4)
/// Wrist slot
#define ITEM_SLOT_WRISTS ITEM_SLOT_EXTRA | (1<<5)

/datum/bitfield/no_equip_flags/New()
	var/list/extra_flags = list(
		"BRIEFS" = ITEM_SLOT_UNDERWEAR,
		"SOCKS" = ITEM_SLOT_SOCKS,
		"SHIRT" = ITEM_SLOT_SHIRT,
		"BRA" = ITEM_SLOT_BRA,
		"EARPIECES_R" = ITEM_SLOT_EARS_RIGHT,
		"WRISTS" = ITEM_SLOT_WRISTS,
	)
	flags += extra_flags
	. = ..()
