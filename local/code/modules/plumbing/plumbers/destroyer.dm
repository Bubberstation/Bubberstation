#define DISPOSER_UPGRADED_RATE 390

/obj/machinery/plumbing/disposer
	var/bs_crystal_attached = FALSE

/obj/machinery/plumbing/disposer/examine(mob/user)
	. = ..()
	if(!bs_crystal_attached)
		. += span_boldnotice("You could probably upgrade this with a [/obj/item/stack/sheet/bluespace_crystal::name]...")
	else
		. += span_notice("It has a [/obj/item/stack/sheet/bluespace_crystal::name] attached, allowing it to dispose of liquids faster.")

/obj/machinery/plumbing/disposer/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/sheet/bluespace_crystal) && bs_crystal_attached == FALSE)
		balloon_alert(user, "attached")
		I.use(1)
		bs_crystal_attached = TRUE
		disposal_rate = DISPOSER_UPGRADED_RATE // GO GO GADGET SUCK
	return ..()

/obj/machinery/plumbing/disposer/upgraded
	bs_crystal_attached = TRUE
	disposal_rate = DISPOSER_UPGRADED_RATE
	processing_flags = START_PROCESSING_ON_INIT // For Sigma Octantis

#undef DISPOSER_UPGRADED_RATE
