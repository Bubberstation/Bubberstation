#define SHELL_BOX_EMBLEM_LIGHTNESS_CUTOFF 55
#define SHELL_BOX_EMBLEM_DARK "#1a1a1a"
#define SHELL_BOX_EMBLEM_LIGHT "#ffffff"

// catch-all for admins, and the unit test's stand-in for shells nobody boxed yet
/obj/item/ammo_box/advanced/s12gauge/generic
	name = "shotgun shell ammo box"
	desc = "A box of 7 shotgun shells of some kind."
	icon = 'modular_zubbers/icons/obj/weapons/guns/shotgun_shell_box_gags.dmi'
	icon_state = SHELL_BOX_SPRITE_N

/obj/item/ammo_box/advanced/s12gauge/generic/Initialize(mapload)
	apply_generic_art(ammo_type)
	return ..()

/obj/item/ammo_box/advanced/s12gauge/generic/proc/apply_generic_art(obj/item/ammo_casing/shotgun/shell_type)
	greyscale_config = /datum/greyscale_config/shotgun_shell_box
	greyscale_colors = expand_box_colors(initial(shell_type.box_colors))
	base_icon_state = initial(shell_type.box_sprite)
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/advanced/s12gauge/generic/proc/expand_box_colors(colors)
	if(length(splittext(colors, "#")) > 2)
		return colors
	// one color given: hulls match the sleeve, the emblem goes dark or light to stand out
	var/list/hsl = rgb2num(colors, COLORSPACE_HSL)
	return "[colors][colors][hsl[3] > SHELL_BOX_EMBLEM_LIGHTNESS_CUTOFF ? SHELL_BOX_EMBLEM_DARK : SHELL_BOX_EMBLEM_LIGHT]"

/obj/item/ammo_box/advanced/s12gauge/generic/proc/dress_for_shell(obj/item/ammo_casing/shotgun/shell_type)
	ammo_type = shell_type
	name = "generic [initial(shell_type.name)] ammo box"
	desc = "A box of [initial(shell_type.name)] 12 gauge shotgun shells. The label is smeary and the plastic feels cheap. It looks like someone really skimped on quality when producing these..."
	apply_generic_art(shell_type)
	update_greyscale()
	update_appearance()

/obj/item/ammo_box/advanced/s12gauge/milspec
	name = "Milspec Slug ammo box"
	desc = "A box of 7 milspec slugs, you're not sure what the hell makes these more robust than any other shotgun slugs."
	icon_state = "milspec"
	ammo_type = /obj/item/ammo_casing/shotgun/milspec

/obj/item/ammo_box/advanced/s12gauge/milspec_buckshot
	name = "Milspec Buckshot ammo box"
	desc = "A box of 7 milspec buckshot shells. Clearly built for hunting military grade deer."
	icon_state = "milspec_buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot/milspec

/obj/item/ammo_box/advanced/s12gauge/executioner
	name = "Executioner Slug ammo box"
	desc = "A box of 7 slugs, you can't make out a manufacturer, but the badass skull on the box tells you they're pretty serious."
	icon_state = "executioner"
	ammo_type = /obj/item/ammo_casing/shotgun/executioner

/obj/item/ammo_box/advanced/s12gauge/pulverizer
	name = "Pulverizer Slug ammo box"
	desc = "A box of 7 pulverizer slugs. You question who would make something like this, and why."
	icon_state = "pulverizer"
	ammo_type = /obj/item/ammo_casing/shotgun/pulverizer

/obj/item/ammo_box/advanced/s12gauge/precision_incendiary
	name = "Precision Incendiary Slug ammo box"
	desc = "A box of 7 precision incendiary slugs. Clever technological developments have managed to produce bullets that only light the thing you hit on fire."
	icon_state = "precision_incendiary"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary/no_trail

/obj/item/ammo_box/advanced/s12gauge/taser
	name = "Taser Slug ammo box"
	desc = "A box of 7 taser slugs. The slogan \"FEAR THE WRATH OF THE GOLDEN BOLT\" is written on the side."
	icon_state = "taser"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/advanced/s12gauge/meteor
	name = "Meteor Slug ammo box"
	desc = "A box of 7 meteor slugs. Despite its compact appearance, you are baffled at the fact this box seems to weigh about 20 pounds."
	icon_state = "meteor"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug

/obj/item/ammo_box/advanced/s12gauge/frag12
	name = "FRAG-12 ammo box"
	desc = "A box of 7 FRAG-12 slugs. The box is completely covered in warning labels, you've got a bad feeling about this..."
	icon_state = "frag12"
	ammo_type = /obj/item/ammo_casing/shotgun/frag12

/obj/item/ammo_box/advanced/s12gauge/old_buckshot
	name = "Old Buckshot ammo box"
	desc = "A box of 7 old buckshot shells. You didn't know bullets had an expiration date...?"
	icon_state = "old_buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot/old

/obj/item/ammo_box/advanced/s12gauge/spent_buckshot
	name = "Spent Buckshot ammo box"
	desc = "A box of 7 spent buckshot shells. What the fuck, is this some kind of joke?"
	icon_state = "spent_buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot/spent

/obj/item/ammo_box/advanced/s12gauge/hornets_nest
	name = "Hornet's Nest ammo box"
	desc = "A box of 7 hornet's nest shells. The box offers some friendly looking cartoon bees and no clues about what the actual bullets do."
	icon_state = "hornets_nest"
	ammo_type = /obj/item/ammo_casing/shotgun/incapacitate

/obj/item/ammo_box/advanced/s12gauge/ion
	name = "Ion Shell ammo box"
	desc = "A box of 7 Ion shells. There's a crude drawing of a cyborg exploding on the side."
	icon_state = "ion"
	ammo_type = /obj/item/ammo_casing/shotgun/ion

/obj/item/ammo_box/advanced/s12gauge/techshell
	name = "Technological Shell ammo box"
	desc = "A box of 7 unloaded technological shells. Useless on their own, you get the feeling you aren't supposed to have this."
	icon_state = "techshell"
	ammo_type = /obj/item/ammo_casing/shotgun/techshell

/obj/item/ammo_box/advanced/s12gauge/dart
	name = "Shotgun Dart ammo box"
	desc = "A box of 7 empty shotgun darts. ostensibly a medical device."
	icon_state = "dart"
	ammo_type = /obj/item/ammo_casing/shotgun/dart

/obj/item/ammo_box/advanced/s12gauge/dart_large
	name = "XL Shotgun Dart ammo box"
	desc = "A box of 7 empty XL shotgun darts. ostensibly a medical device."
	icon_state = "dart_large"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/large

/obj/item/ammo_box/advanced/s12gauge/dart_bioterror
	name = "Bioterror Dart ammo box"
	desc = "A box of 7 bioterror darts. Lovingly prefilled by Interdyne bioweapons scientists with something unpleasant to living beings."
	icon_state = "dart_bioterror"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/obj/item/ammo_box/advanced/s12gauge/hornet
	name = "Hornet Shell ammo box"
	desc = "A box of 7 hornet shells. One wonders what the goal of this branding was, they mostly just bounce."
	icon_state = "beehive"
	ammo_type = /obj/item/ammo_casing/shotgun/beehive

/obj/item/ammo_box/advanced/s12gauge/junk
	name = "Improvised Shell ammo box"
	desc = "A box of 7 improvised shells, the engineering behind this box demonstrates far more love and care than these rounds could possibly warrant."
	icon_state = "junk"
	ammo_type = /obj/item/ammo_casing/shotgun/junk

/obj/item/ammo_box/advanced/s12gauge/junk/empty
	start_empty = TRUE

/obj/item/ammo_box/advanced/s12gauge/donk
	name = "\improper Donk Spike ammo box"
	desc = "A box of 7 'Donk Spike' shells. Each shell holds a fistful of plastic flechettes nobody else wanted. Looks like a donk-pocket! \
		Eat and/or microwave at your own risk. Donk Co assumes no liability for damaged teeth or bodily tissue."
	icon_state = "donk"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette/donk
	// must match /datum/design/advancedgaugeboxes_donk exactly or the design_mats unit test fails
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 35, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

#undef SHELL_BOX_EMBLEM_LIGHTNESS_CUTOFF
#undef SHELL_BOX_EMBLEM_DARK
#undef SHELL_BOX_EMBLEM_LIGHT
