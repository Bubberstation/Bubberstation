/// Create briefs from underwear sprite accessories
#define BRIEFS_FROM_SPRITE_ACCESSORY(class_name) \
/obj/item/clothing/underwear/briefs/##class_name{\
	name = /datum/sprite_accessory/underwear/##class_name::name; \
	icon = /datum/sprite_accessory/underwear/##class_name::icon; \
	worn_icon = /datum/sprite_accessory/underwear/##class_name::icon; \
	worn_icon_digi = /datum/sprite_accessory/underwear/##class_name::icon; \
	icon_state = /datum/sprite_accessory/underwear/##class_name::icon_state; \
	gender = /datum/sprite_accessory/underwear/##class_name::gender; \
	flags_1 = /obj/item/clothing/underwear/briefs::flags_1 | (IS_PLAYER_COLORABLE_1 * !(/datum/sprite_accessory/underwear/##class_name::use_static)); \
	supports_variations_flags = /datum/sprite_accessory/underwear/##class_name::has_digitigrade * CLOTHING_DIGITIGRADE_VARIATION || CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON; \
	body_parts_covered = /obj/item/clothing/underwear/briefs::body_parts_covered | /datum/sprite_accessory/underwear/##class_name::hides_breasts * CHEST; \
};\
/obj/item/clothing/underwear/briefs/##class_name/Initialize(mapload){\
	if(isnull(female_sprite_flags)) {\
		female_sprite_flags = NO_FEMALE_UNIFORM;\
	} else if(female_sprite_flags == /obj/item/clothing/underwear::female_sprite_flags) {\
		female_sprite_flags = gender == MALE ? (FEMALE_UNIFORM_FULL | FEMALE_UNIFORM_DIGI_FULL) : NO_FEMALE_UNIFORM; \
	};\
	. = ..();\
};\
/datum/sprite_accessory/underwear/##class_name{\
	briefs_obj = /obj/item/clothing/underwear/briefs/##class_name; \
};

/// Create shirt from undershirt sprite accessories
#define SHIRT_FROM_SPRITE_ACCESSORY(class_name) \
/obj/item/clothing/underwear/shirt/##class_name {\
	name = /datum/sprite_accessory/undershirt/##class_name::name; \
	icon = /datum/sprite_accessory/undershirt/##class_name::icon; \
	worn_icon = /datum/sprite_accessory/undershirt/##class_name::icon; \
	worn_icon_digi = /datum/sprite_accessory/undershirt/##class_name::icon; \
	icon_state = /datum/sprite_accessory/undershirt/##class_name::icon_state; \
	gender = /datum/sprite_accessory/undershirt/##class_name::gender; \
	flags_1 = /obj/item/clothing/underwear/shirt::flags_1 | (IS_PLAYER_COLORABLE_1 * !(/datum/sprite_accessory/undershirt/##class_name::use_static)); \
	body_parts_covered = /obj/item/clothing/underwear/shirt::body_parts_covered | GROIN * /datum/sprite_accessory/undershirt/##class_name::hides_groin; \
};\
/obj/item/clothing/underwear/shirt/##class_name/Initialize(mapload) {\
	if(isnull(female_sprite_flags)) {\
		female_sprite_flags = NO_FEMALE_UNIFORM;\
	} else if(female_sprite_flags == /obj/item/clothing/underwear::female_sprite_flags) {\
		female_sprite_flags = gender == MALE ? (FEMALE_UNIFORM_FULL | FEMALE_UNIFORM_DIGI_FULL) : NO_FEMALE_UNIFORM;\
	};\
	. = ..();\
};\
/datum/sprite_accessory/undershirt/##class_name {\
	shirt_obj = /obj/item/clothing/underwear/shirt/##class_name; \
};

/// Create bra from bra sprite accessories
#define BRA_FROM_SPRITE_ACCESSORY(class_name) \
/obj/item/clothing/underwear/shirt/bra/##class_name {\
	name = /datum/sprite_accessory/bra/##class_name::name; \
	icon = /datum/sprite_accessory/bra/##class_name::icon; \
	worn_icon = /datum/sprite_accessory/bra/##class_name::icon; \
	worn_icon_digi = /datum/sprite_accessory/bra/##class_name::icon; \
	icon_state = /datum/sprite_accessory/bra/##class_name::icon_state; \
	gender = /datum/sprite_accessory/bra/##class_name::gender; \
	flags_1 = /obj/item/clothing/underwear/shirt/bra::flags_1 | (IS_PLAYER_COLORABLE_1 * !(/datum/sprite_accessory/bra/##class_name::use_static)); \
};\
/datum/sprite_accessory/bra/##class_name {\
	bra_obj = /obj/item/clothing/underwear/shirt/bra/##class_name; \
};

/// Create socks from socks sprite accessories
#define SOCKS_FROM_SPRITE_ACCESSORY(class_name) \
/obj/item/clothing/underwear/socks/##class_name {\
	name = /datum/sprite_accessory/socks/##class_name::name; \
	icon = /datum/sprite_accessory/socks/##class_name::icon; \
	worn_icon = /datum/sprite_accessory/socks/##class_name::icon; \
	worn_icon_digi = /datum/sprite_accessory/socks/##class_name::icon; \
	icon_state = /datum/sprite_accessory/socks/##class_name::icon_state; \
	flags_1 = /obj/item/clothing/underwear/socks::flags_1 | (IS_PLAYER_COLORABLE_1 * !(/datum/sprite_accessory/socks/##class_name::use_static)); \
};\
/datum/sprite_accessory/socks/##class_name {\
	socks_obj = /obj/item/clothing/underwear/socks/##class_name; \
};

/// Create briefs directly as an object, and its sprite accessory
#define BRIEFS_OBJECT(class_name) \
/datum/sprite_accessory/underwear/##class_name{ \
	name = /obj/item/clothing/underwear/briefs/##class_name::name;\
	icon = /obj/item/clothing/underwear/briefs/##class_name::icon;\
	gender = /obj/item/clothing/underwear/briefs/##class_name::gender;\
	icon_state = /obj/item/clothing/underwear/briefs/##class_name::icon_state;\
	use_static = !(/obj/item/clothing/underwear/briefs/##class_name::flags_1 & IS_PLAYER_COLORABLE_1);\
	hides_breasts = !!(/obj/item/clothing/underwear/briefs/##class_name::body_parts_covered & CHEST);\
	briefs_obj = /obj/item/clothing/underwear/briefs/##class_name;\
	from_object = TRUE;\
};\
/obj/item/clothing/underwear/briefs/##class_name

/// Create shirt directly as an object, and its sprite accessory
#define SHIRT_OBJECT(class_name) \
/datum/sprite_accessory/undershirt/##class_name{ \
	name = /obj/item/clothing/underwear/shirt/##class_name::name;\
	icon = /obj/item/clothing/underwear/shirt/##class_name::icon;\
	gender = /obj/item/clothing/underwear/shirt/##class_name::gender;\
	icon_state = /obj/item/clothing/underwear/shirt/##class_name::icon_state;\
	use_static = !(/obj/item/clothing/underwear/shirt/##class_name::flags_1 & IS_PLAYER_COLORABLE_1);\
	hides_groin = !!(/obj/item/clothing/underwear/shirt/##class_name::body_parts_covered & CHEST);\
	shirt_obj = /obj/item/clothing/underwear/shirt/##class_name;\
	from_object = TRUE;\
};\
/obj/item/clothing/underwear/shirt/##class_name

/// Create bra directly as an object, and its sprite accessory
#define BRA_OBJECT(class_name) \
/datum/sprite_accessory/bra/##class_name{ \
	name = /obj/item/clothing/underwear/shirt/bra/##class_name::name;\
	icon = /obj/item/clothing/underwear/shirt/bra/##class_name::icon;\
	gender = /obj/item/clothing/underwear/shirt/bra/##class_name::gender;\
	icon_state = /obj/item/clothing/underwear/shirt/bra/##class_name::icon_state;\
	use_static = !(/obj/item/clothing/underwear/shirt/bra/##class_name::flags_1 & IS_PLAYER_COLORABLE_1);\
	bra_obj = /obj/item/clothing/underwear/shirt/bra/##class_name;\
	from_object = TRUE;\
};\
/obj/item/clothing/underwear/shirt/bra/##class_name

/// Create socks directly as an object, and its sprite accessory
#define SOCKS_OBJECT(class_name) \
/datum/sprite_accessory/socks/##class_name{ \
	name = /obj/item/clothing/underwear/socks/##class_name::name;\
	icon = /obj/item/clothing/underwear/socks/##class_name::icon;\
	gender = /obj/item/clothing/underwear/socks/##class_name::gender;\
	icon_state = /obj/item/clothing/underwear/socks/##class_name::icon_state;\
	use_static = !(/obj/item/clothing/underwear/socks/##class_name::flags_1 & IS_PLAYER_COLORABLE_1);\
	socks_obj = /obj/item/clothing/underwear/socks/##class_name;\
	from_object = TRUE;\
};\
/obj/item/clothing/underwear/socks/##class_name
