/datum/supply_pack/misc/ouija_board
	name = "Séance starter kit"
	desc = "Is Ruins and Space Dragons not enough for you? Have you felt a lack of the occult \
		in your poke-carps? Fear not, the Donk Co. spirit board is here, brought to you by an awesome \
		collaboration with the cults of Nar'Sie! (Not intended for use by people with heart conditions)"
	cost = CARGO_CRATE_VALUE * 9 // Donk Co sure loves their money, and a collab this fat? Wowee, they need to get PAID.
	access_view = ACCESS_CHAPEL_OFFICE
	crate_type = /obj/structure/closet/crate/wooden
	contains = list()
	crate_name = "seance starter kit"


/datum/supply_pack/misc/ouija_board/fill(obj/structure/closet/crate/our_crate)
	new /obj/item/storage/fancy/candle_box(our_crate)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(our_crate)
	if(prob(85))
		new /obj/structure/spirit_board(our_crate)
	else
		new /obj/structure/spirit_board/weegee(our_crate)


/datum/supply_pack/engineering/constructionkit
	name = "Construction Kit Crate"
	desc = "For all those DIY projects without all the running around. Contains a toolset, welding helmet, and varied materials."
	contains = list(
		/obj/item/storage/belt/utility/full, // Yes, this is a filled toolbelt.
		/obj/item/clothing/head/utility/welding,
		/obj/item/stack/sheet/mineral/wood/fifty, // ~600 or x 3 Crate Cost from Wood Plank Crate
		/obj/item/stack/sheet/iron/fifty = 2, // ~400 or x 2 Crate Cost from Iron Sheet Crate
		/obj/item/stack/sheet/glass/fifty, // ~400 or x 2 Crate Cost from Glass Sheet Crate
		/obj/item/stack/sheet/cloth/ten = 5, // Curtains, Bedseets, Towels
		/obj/item/stack/sheet/rglass = 20, // ~60 Credits
		/obj/item/survivalcapsule/fan = 2, // ~200 from Imports
		/obj/item/construction/rtd, // RLD is 500, maybe this should be similar?
		/obj/item/storage/box/lights/mixed, // 200
		/obj/item/toy/crayon/spraycan = 3,
	)
	cost = 3000
	crate_name = "construction kit crate"
