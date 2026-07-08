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
	new /obj/item/skillchip/job/blacksmith(src)
	new /obj/item/skillchip/job/blacksmith(src)

/obj/structure/closet/secure_closet/quartermaster/PopulateContents()
	. = ..()
	new /obj/item/storage/box/skillchips/supply(src)
