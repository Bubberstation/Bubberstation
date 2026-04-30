/obj/item/skillchip/job/blacksmith
	name = "Smithing F0RG-3M4573-R skillchip"
	desc = "Grants skills related to blacksmithing and metalworking."
	auto_traits = list(TRAIT_KNOW_ADVANCED_SMITHING, TRAIT_KNOW_GUNSMITHING, TRAIT_KNOW_CIRCUIT_SMITHING)
	skill_name = "Advanced Smithing"
	skill_description = "Contains schematics for more advanced equipment forging, as well as how to best apply it."
	skill_icon = "gavel"
	activate_message = span_notice("You suddenly know how to make advanced metalworking components out of raw materials.")
	deactivate_message = span_notice("The memories of how to construct advanced metalworking components fade from your mind.")

/obj/item/storage/box/skillchips/supply
	name = "box of supply job skillchips"
	desc = "Contains spares of every supply job skillchip."

/obj/item/storage/box/skillchips/supply/PopulateContents()
	new/obj/item/skillchip/job/blacksmith(src)
	new/obj/item/skillchip/job/blacksmith(src)

/datum/supply_pack/misc/smithing_skillchips
	name = "Smithing Skillchips Crate"
	desc = "Learn the art of metalworking and build your own weapons! Contains two smithing skillchips."
	cost = CARGO_CRATE_VALUE * 4
	access = list(ACCESS_WEAPONS)
	contains = list(/obj/item/storage/box/skillchips/supply,)
