/datum/loadout_category/toys
	category_name = "Toys"
	category_ui_icon = FA_ICON_GOLF_BALL
	type_to_generate = /datum/loadout_item/toys
	tab_order = /datum/loadout_category/head::tab_order + 13

/datum/loadout_item/toys/plush
	group = "Plushies"
	abstract_type = /datum/loadout_item/toys/plush

/datum/loadout_item/toys/plush/shark
	name = "Shark Plushie"
	item_path = /obj/item/toy/plush/shark

/datum/loadout_item/toys/plush/narsie
	name = "Nar'sie Plushie"
	item_path = /obj/item/toy/plush/narplush

/datum/loadout_item/toys/plush/ratvar
	name = "Ratvar Plushie"
	item_path = /obj/item/toy/plush/ratplush

/datum/loadout_item/toys/plush/slime
	name = "Slime Plushie"
	item_path = /obj/item/toy/plush/slimeplushie

/datum/loadout_item/toys/plush/bubble
	name = "Bubblegum Plushie"
	item_path = /obj/item/toy/plush/bubbleplush

/datum/loadout_item/toys/plush/sechound
	name = "Sechound Plushie"
	item_path = /obj/item/toy/plush/skyrat/sechound

/datum/loadout_item/toys/plush/medihound
	name = "Medihound Plushie"
	item_path = /obj/item/toy/plush/skyrat/medihound

/datum/loadout_item/toys/plush/engihound
	name = "Engihound Plushie"
	item_path = /obj/item/toy/plush/skyrat/engihound

/datum/loadout_item/toys/plush/scrubpuppy
	name = "Scrubpuppy Plushie"
	item_path = /obj/item/toy/plush/skyrat/scrubpuppy

/datum/loadout_item/toys/plush/meddrake
	name = "MediDrake Plushie"
	item_path = /obj/item/toy/plush/skyrat/meddrake

/datum/loadout_item/toys/plush/secdrake
	name = "SecDrake Plushie"
	item_path = /obj/item/toy/plush/skyrat/secdrake

/datum/loadout_item/toys/plush/borbplushie
	name = "Borb Plushie"
	item_path = /obj/item/toy/plush/skyrat/borbplushie

/datum/loadout_item/toys/plush/deer
	name = "Deer Plushie"
	item_path = /obj/item/toy/plush/skyrat/deer

/datum/loadout_item/toys/plush/fermis
	name = "Medcat Plushie"
	item_path = /obj/item/toy/plush/skyrat/fermis

/datum/loadout_item/toys/plush/chen
	name = "Securicat Plushie"
	item_path = /obj/item/toy/plush/skyrat/fermis/chen

/datum/loadout_item/toys/plush/fox

/datum/loadout_item/toys/cards
	group = "Cards"
	abstract_type = /datum/loadout_item/toys/cards


/datum/loadout_item/toys/cards/tarot
	name = "Tarot Card Deck"
	item_path = /obj/item/toy/cards/deck/tarot

/datum/loadout_item/toys/ball
	group = "Playing Balls"
	abstract_type = /datum/loadout_item/toys/ball

/datum/loadout_item/toys/ball/tennis
	name = "Tennis Ball (Classic)"
	item_path = /obj/item/toy/tennis

/datum/loadout_item/toys/ball/tennisred
	name = "Tennis Ball (Red)"
	item_path = /obj/item/toy/tennis/red

/datum/loadout_item/toys/ball/tennisyellow
	name = "Tennis Ball (Yellow)"
	item_path = /obj/item/toy/tennis/yellow

/datum/loadout_item/toys/ball/tennisgreen
	name = "Tennis Ball (Green)"
	item_path = /obj/item/toy/tennis/green

/datum/loadout_item/toys/ball/tenniscyan
	name = "Tennis Ball (Cyan)"
	item_path = /obj/item/toy/tennis/cyan

/datum/loadout_item/toys/ball/tennisblue
	name = "Tennis Ball (Blue)"
	item_path = /obj/item/toy/tennis/blue

/datum/loadout_item/toys/ball/tennispurple
	name = "Tennis Ball (Purple)"
	item_path = /obj/item/toy/tennis/purple

/datum/loadout_item/toys/art
	group = "Art Supplies"
	abstract_type = /datum/loadout_item/toys/art

/datum/loadout_item/toys/art/crayons
	name = "Box of Crayons"
	item_path = /obj/item/storage/crayons

/datum/loadout_item/toys/art/spray_can
	name = "Spray Can"
	item_path = /obj/item/toy/crayon/spraycan

/datum/loadout_item/toys/misc
	group = "Miscellaneous Toys"

/datum/loadout_item/toys/cat_toy
	name = "Cat Toy"
	item_path = /obj/item/toy/cattoy

/datum/loadout_item/toys/eightball
	name = "Magic Eightball"
	item_path = /obj/item/toy/eightball

/datum/loadout_item/toys/toykatana
	name = "Toy Katana"
	item_path = /obj/item/toy/katana

/datum/loadout_item/toys/red_laser
	name = "Red Laser Pointer"
	item_path = /obj/item/laser_pointer/limited/red

/datum/loadout_item/toys/green_laser
	name = "Green Laser Pointer"
	item_path = /obj/item/laser_pointer/limited/green

/datum/loadout_item/toys/blue_laser
	name = "Blue Laser Pointer"
	item_path = /obj/item/laser_pointer/limited/blue

/datum/loadout_item/toys/purple_laser
	name = "Purple Laser Pointer"
	item_path = /obj/item/laser_pointer/limited/purple

/datum/loadout_item/toys/nyamagotchi
	name = "Nyamagotchi"
	item_path = /obj/item/toy/nyamagotchi
	ui_icon = 'modular_zubbers/icons/obj/toys/toys.dmi'
	ui_icon_state = "nya"
