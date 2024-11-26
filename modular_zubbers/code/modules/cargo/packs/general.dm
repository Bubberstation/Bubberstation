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

