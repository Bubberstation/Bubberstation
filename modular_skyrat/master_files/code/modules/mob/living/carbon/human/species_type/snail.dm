#define SHELL_TRANSPARENCY_ALPHA 90

/datum/species/snail
	eyes_icon = 'modular_skyrat/modules/organs/icons/snail_eyes.dmi' //This is to consolidate our icons and prevent future calamity.
	mutantliver = /obj/item/organ/liver/snail //This is just a better liver to deal with toxins, it's a thematic thing.
	mutantheart = /obj/item/organ/heart/snail //This gives them the shell buff where they take less damage from behind, and their heart's more durable.
	exotic_bloodtype = null

	eyes_icon = 'modular_skyrat/modules/organs/icons/snail_eyes.dmi'

/datum/species/snail/on_species_gain(mob/living/carbon/new_snailperson, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	new_snailperson.update_icons()

/obj/item/storage/backpack/snail
	/// Whether or not a bluespace anomaly core has been inserted
	var/storage_core = FALSE
	slowdown = 6 // The snail's shell is what's making them slow.
	obj_flags = IMMUTABLE_SLOW //This should hopefully solve other issues involing it as well.
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //This makes them layer over tails like the cult backpack; some tails really shouldn't appear over them!

/obj/item/storage/backpack/snail/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 30
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/snail_shell)

/datum/atom_skin/snail_shell
	abstract_type = /datum/atom_skin/snail_shell

/datum/atom_skin/snail_shell/conical
	preview_name = "Conical Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "coneshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/round
	preview_name = "Round Shell"
	new_icon = 'icons/obj/storage/backpack.dmi'
	new_icon_state = "snailshell"
	new_worn_icon = 'icons/mob/clothing/back/backpack.dmi'

/datum/atom_skin/snail_shell/cinnamon
	preview_name = "Cinnamon Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "cinnamonshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/caramel
	preview_name = "Caramel Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "caramelshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/metal
	preview_name = "Metal Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "mechashell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/pyramid
	preview_name = "Pyramid Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "pyramidshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/pyramid_ivory
	preview_name = "Ivory Pyramid Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "pyramidshellwhite"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/spiral
	preview_name = "Spiral Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "spiralshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/spiral_ivory
	preview_name = "Ivory Spiral Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "spiralshellwhite"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/rocky
	preview_name = "Rocky Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "rockshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/rocky_ivory
	preview_name = "Ivory Rocky Shell"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "rockshellwhite"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/obj/item/storage/backpack/snail/attackby(obj/item/core, mob/user)
	if(!istype(core, /obj/item/assembly/signaler/anomaly/bluespace))
		return ..()

	to_chat(user, span_notice("You insert [core] into your shell, and it starts to glow blue with expanded storage potential!"))
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	add_filter("bluespace_shell", 2, list("type" = "outline", "color" = COLOR_BLUE_LIGHT, "size" = 1))
	storage_core = TRUE
	qdel(core)
	emptyStorage()
	create_storage(max_specific_storage = WEIGHT_CLASS_GIGANTIC, max_total_storage = 35, max_slots = 30, storage_type = /datum/storage/bag_of_holding)
	atom_storage.allow_big_nesting = TRUE
	name = "snail shell of holding"
	user.update_worn_back()
	update_appearance()

/obj/item/storage/backpack/snail/build_worn_icon(
	default_layer = 0,
	default_icon_file = null,
	isinhands = FALSE,
	female_uniform = NO_FEMALE_UNIFORM,
	override_state = null,
	override_file = null,
	mutant_styles = NONE,
)

	var/mutable_appearance/standing = ..()
	if(storage_core == TRUE)
		standing.add_filter("bluespace_shell", 2, list("type" = "outline", "color" = COLOR_BLUE_LIGHT, "alpha" = SHELL_TRANSPARENCY_ALPHA, "size" = 1))
	return standing

/datum/species/snail/prepare_human_for_preview(mob/living/carbon/human/snail)
	snail.dna.features[FEATURE_MUTANT_COLOR] = "#adaba7"
	snail.update_body(TRUE)

/datum/species/snail/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "home",
			SPECIES_PERK_NAME = "Shellback",
			SPECIES_PERK_DESC = "Snails have a shell fused to their back. It offers great storage and most importantly gives them 50% brute damage reduction from behind, or while resting. Alt click to change the sprite!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "wine-glass",
			SPECIES_PERK_NAME = "Poison Resistance",
			SPECIES_PERK_DESC = "Snails have a higher tolerance for poison owing to their robust livers.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "heart",
			SPECIES_PERK_NAME = "Double Hearts",
			SPECIES_PERK_DESC = "Snails have two hearts, meaning it'll take more to break theirs.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "water",
			SPECIES_PERK_NAME = "Water Breathing",
			SPECIES_PERK_DESC = "Snails can breathe underwater.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "Boneless",
			SPECIES_PERK_DESC = "Snails are invertebrates, meaning they don't take bone wounds, but are easier to delimb.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "crutch",
			SPECIES_PERK_NAME = "Sheer Mollusk Speed",
			SPECIES_PERK_DESC = "Snails move incredibly slow while standing. They move much faster while crawling, and can stick to the floors when the gravity is out.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "frown",
			SPECIES_PERK_NAME = "Weak Fighter",
			SPECIES_PERK_DESC = "Snails punch half as hard as a human.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "skull",
			SPECIES_PERK_NAME = "Salt Weakness",
			SPECIES_PERK_DESC = "Salt burns snails, and salt piles will block their path.",
		),
	)

	return to_add

#undef SHELL_TRANSPARENCY_ALPHA
