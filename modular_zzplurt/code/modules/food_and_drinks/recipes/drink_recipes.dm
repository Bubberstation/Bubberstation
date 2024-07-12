//SPLURT drinks
/datum/chemical_reaction/panty_dropper //https://ifunny.co/video/uyksuxGK8?s=cl
	name = "Liquid Panty Dropper"
	id = /datum/reagent/consumable/ethanol/panty_dropper
	results = list(/datum/reagent/consumable/ethanol/panty_dropper = 8, /datum/reagent/drug/aphrodisiacplus = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/screwdrivercocktail = 1, /datum/reagent/consumable/ethanol/gin = 1, /datum/reagent/consumable/ethanol/creme_de_coconut = 1, /datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/ethanol/triple_sec = 1, /datum/reagent/consumable/pineapplejuice = 1, /datum/reagent/consumable/berryjuice = 1) //Can't have the legendary 1:1 ratio or original recipe cuz of recipe clashes :(
	mix_message = "A very tvvisted combination begins to bubble..."

/datum/chemical_reaction/lean
	name = "Lean"
	id = /datum/reagent/consumable/ethanol/lean
	results = list(/datum/reagent/consumable/ethanol/lean = 3)
	required_reagents = list(/datum/reagent/medicine/salbutamol = 1, /datum/reagent/consumable/pwr_game = 1, /datum/reagent/consumable/sugar = 1) // Salbutamol for the cough syrup. Pwr Game for the Sprite, sugar for the candies.
	mix_message = "The mixture turns a deep purple colour."

/datum/chemical_reaction/wockyslush
	name = "Wocky Slush"
	id = /datum/reagent/consumable/wockyslush
	results = list(/datum/reagent/consumable/wockyslush = 5)
	required_reagents = list(/datum/reagent/toxin/fentanyl = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/lemon_lime = 1)
	mix_message = "That thang bleedin' P!"

/datum/chemical_reaction/cum_in_a_hot_tub
	name = "Cum in a Hot Tub"
	id = /datum/reagent/consumable/ethanol/cum_in_a_hot_tub
	results = list(/datum/reagent/consumable/ethanol/cum_in_a_hot_tub = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/ethanol/white_russian = 1, /datum/reagent/consumable/ethanol/irish_cream = 1)

/datum/chemical_reaction/cum_in_a_hot_tub/semen
	name = "Cum in a Hot Tub"
	id = /datum/reagent/consumable/ethanol/cum_in_a_hot_tub/semen
	results = list(/datum/reagent/consumable/ethanol/cum_in_a_hot_tub/semen = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/semen = 1, /datum/reagent/consumable/ethanol/irish_cream = 1)

/datum/chemical_reaction/orange_creamsicle
    name = "Orange Creamsical"
    id = /datum/reagent/consumable/orange_creamsicle
    results = list(/datum/reagent/consumable/orange_creamsicle = 4)
    required_reagents = list(/datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/orangejuice = 1)

/datum/chemical_reaction/mech_rider
	name = "Mech Rider"
	id = /datum/reagent/consumable/ethanol/mech_rider
	results = list(/datum/reagent/consumable/ethanol/mech_rider = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/absinthe = 1, /datum/reagent/consumable/ethanol/hcider = 1, /datum/reagent/consumable/ethanol/syndicatebomb = 1, /datum/reagent/consumable/coffee = 1)

/datum/chemical_reaction/isloation_cell
	name = "Isolation Cell"
	id = /datum/reagent/consumable/ethanol/isloation_cell
	results = list(/datum/reagent/consumable/ethanol/isloation_cell = 5)
	required_reagents = list(
		/datum/reagent/drug/aphrodisiac = 1,
		/datum/reagent/medicine/synaptizine = 2,
		/datum/reagent/consumable/ethanol/hippies_delight = 2
	)

/datum/chemical_reaction/isloation_cell/morphine
	id = /datum/reagent/consumable/ethanol/isloation_cell/morphine
	results = list(/datum/reagent/consumable/ethanol/isloation_cell/morphine = 5)
	required_reagents = list(
		/datum/reagent/drug/aphrodisiac = 1,
		/datum/reagent/medicine/morphine = 2,
		/datum/reagent/consumable/ethanol/hippies_delight = 2
	)

/datum/chemical_reaction/chemical_ex
	name = "Chemical Ex"
	id = /datum/reagent/consumable/ethanol/chemical_ex
	results = list(/datum/reagent/consumable/ethanol/chemical_ex = 5)
	required_reagents = list(
		/datum/reagent/drug/aphrodisiacplus = 1,
		/datum/reagent/medicine/morphine = 2,
		/datum/reagent/fermi/enthrall = 2
	)

/datum/chemical_reaction/heart_of_gold
	name = "Heart Of Gold"
	id = /datum/reagent/consumable/ethanol/heart_of_gold
	results = list(/datum/reagent/consumable/ethanol/heart_of_gold = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/jack_rose = 4,
		/datum/reagent/consumable/peachjuice = 3,
		/datum/reagent/consumable/pineapplejuice = 3
	)

/datum/chemical_reaction/moth_in_chief
	name = "Moth in Chief"
	id = /datum/reagent/consumable/ethanol/moth_in_chief
	results = list(/datum/reagent/consumable/ethanol/moth_in_chief = 4)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/commander_and_chief = 1,
		/datum/reagent/mutationtoxin/insect = 1,
		/datum/reagent/drug/copium = 1,
		/datum/reagent/medicine/stimulants = 1
	)


// ~( Ported from TG )~
/datum/chemical_reaction/admiralty
	name = "Admiralty"
	id = /datum/reagent/consumable/ethanol/admiralty
	results = list(/datum/reagent/consumable/ethanol/admiralty = 5)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/navy_rum = 3,
		/datum/reagent/consumable/ethanol/vermouth = 1,
		/datum/reagent/consumable/ethanol/fernet = 1
	)

/datum/chemical_reaction/dark_n_stormy
	name = "Dark and Stormy"
	id = /datum/reagent/consumable/ethanol/dark_and_stormy
	results = list(/datum/reagent/consumable/ethanol/dark_and_stormy = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/rum = 3,
		/datum/reagent/consumable/sol_dry = 7
	)

/datum/chemical_reaction/long_john_silver
	name = "Long John Silver"
	id = /datum/reagent/consumable/ethanol/long_john_silver
	results = list(/datum/reagent/consumable/ethanol/long_john_silver = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/navy_rum = 4,
		/datum/reagent/consumable/ethanol/bitters = 1,
		/datum/reagent/consumable/lemonade = 5
	)

/datum/chemical_reaction/long_haul
	name = "Long Haul"
	id = /datum/reagent/consumable/ethanol/long_haul
	results = list(/datum/reagent/consumable/ethanol/long_haul = 25)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/navy_rum = 4,
		/datum/reagent/consumable/ethanol/curacao = 3,
		/datum/reagent/consumable/sugar= 2,
		/datum/reagent/consumable/ethanol/bitters = 1,
		/datum/reagent/consumable/sodawater = 15
	)

/datum/chemical_reaction/salt_and_swell
	name = "Salt and Swell"
	id = /datum/reagent/consumable/ethanol/salt_and_swell
	results = list(/datum/reagent/consumable/ethanol/salt_and_swell = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/navy_rum = 4,
		/datum/reagent/consumable/toechtauese_syrup = 3,
		/datum/reagent/consumable/eggwhite = 2,
		/datum/reagent/medicine/salglu_solution = 1
	)

/datum/chemical_reaction/tich_toch
	name = "Tich Toch"
	id = /datum/reagent/consumable/ethanol/tich_toch
	results = list(/datum/reagent/consumable/ethanol/tich_toch = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/tiltaellen = 6,
		/datum/reagent/consumable/toechtauese_syrup = 2,
		/datum/reagent/consumable/ethanol/vodka = 2
	)

/datum/chemical_reaction/tiltaellen
	name = "Tiltällen"
	id = /datum/reagent/consumable/ethanol/tiltaellen
	results = list(/datum/reagent/consumable/ethanol/tiltaellen = 10)
	required_reagents = list(
		/datum/reagent/consumable/yoghurt = 8,
		/datum/reagent/consumable/vinegar = 1,
		/datum/reagent/consumable/sodiumchloride = 1
	)
	mix_message = "The mixture curdles and thickens."

/datum/chemical_reaction/tropical_storm
	name = "Tropical Storm"
	id = /datum/reagent/consumable/ethanol/tropical_storm
	results = list(/datum/reagent/consumable/ethanol/tropical_storm = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/rum = 2,
		/datum/reagent/consumable/ethanol/curacao = 2,
		/datum/reagent/consumable/triple_citrus = 4,
		/datum/reagent/consumable/pineapplejuice = 2
	)

/datum/chemical_reaction/skullfucker_deluxe
	name = "Skullfucker Deluxe"
	id = /datum/reagent/consumable/ethanol/skullfucker_deluxe
	results = list(/datum/reagent/consumable/ethanol/skullfucker_deluxe = 5)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/sugar_rush = 2,
		/datum/reagent/consumable/ethanol/moonshine = 2,
		/datum/reagent/consumable/ethanol/brave_bull = 1
	)

//Milkshakes
/datum/chemical_reaction/milkshake_base
	name = "Plain Milkshake"
	id = /datum/reagent/consumable/milkshake_base
	results = list(/datum/reagent/consumable/milkshake_base = 3)
	required_reagents = list(
		/datum/reagent/consumable/milk = 1,
		/datum/reagent/consumable/ice = 1,
		/datum/reagent/consumable/cream =1
	)

/datum/chemical_reaction/milkshake_vanilla
	name = "Vanilla Milkshake"
	id = /datum/reagent/consumable/milkshake_vanilla
	results = list(/datum/reagent/consumable/milkshake_vanilla = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base =1,
		/datum/reagent/consumable/vanilla =1
	)

/datum/chemical_reaction/milkshake_choc
	name = "Chocolate Milkshake"
	id = /datum/reagent/consumable/milkshake_choc
	results = list(/datum/reagent/consumable/milkshake_choc = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/coco = 1
	)

/datum/chemical_reaction/milkshake_strawberry
	name = "Strawberry Milkshake"
	id = /datum/reagent/consumable/milkshake_strawberry
	results = list(/datum/reagent/consumable/milkshake_strawberry = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/strawberryjuice = 1
	)

/datum/chemical_reaction/milkshake_banana
	name = "Banana Milkshake"
	id = /datum/reagent/consumable/milkshake_banana
	results = list(/datum/reagent/consumable/milkshake_banana = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/banana = 1
	)

/datum/chemical_reaction/milkshake_berry
	name = "Berry Milkshake"
	id = /datum/reagent/consumable/milkshake_berry
	results = list(/datum/reagent/consumable/milkshake_berry = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/berryjuice = 1
	)

/datum/chemical_reaction/milkshake_cola
	name = "Cola Milkshake"
	id = /datum/reagent/consumable/milkshake_cola
	results = list(/datum/reagent/consumable/milkshake_cola = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/space_cola = 1
	)

/datum/chemical_reaction/milkshake_gibb
	name = "Dr. Gibb Milkshake"
	id = /datum/reagent/consumable/milkshake_gibb
	results = list(/datum/reagent/consumable/milkshake_gibb = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/dr_gibb = 1
	)

/datum/chemical_reaction/milkshake_peach
	name = "Peach Milkshake"
	id = /datum/reagent/consumable/milkshake_peach
	results = list(/datum/reagent/consumable/milkshake_peach = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/peachjuice = 1
	)

/datum/chemical_reaction/milkshake_pineapple
	name = "Pineapple Milkshake"
	id = /datum/reagent/consumable/milkshake_pineapple
	results = list(/datum/reagent/consumable/milkshake_pineapple = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/pineapplejuice = 1
	)

/datum/chemical_reaction/milkshake_melon
	name = "Watermelon Milkshake"
	id = /datum/reagent/consumable/milkshake_melon
	results = list(/datum/reagent/consumable/milkshake_melon = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/watermelonjuice = 1
	)

/datum/chemical_reaction/ionstorm
	name = "Ion Storm"
	id = /datum/reagent/consumable/ethanol/ionstorm
	results = list(/datum/reagent/consumable/ethanol/ionstorm = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/quadruple_sec = 5,
		/datum/reagent/consumable/ethanol/bastion_bourbon = 2
	)
	mix_message = "The lights flicker for a moment..."
	mix_sound = 'sound/weapons/taser.ogg'

/datum/chemical_reaction/twinkjuice
	name = "Twink Juice"
	id = /datum/reagent/consumable/ethanol/twinkjuice
	results = list(/datum/reagent/consumable/ethanol/twinkjuice = 6)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/vodka = 3,
		/datum/reagent/consumable/berryjuice = 2,
		/datum/reagent/lube = 1
	)
	mix_message = "Oooo you like kissing booooys"
	mix_sound = 'modular_splurt/sound/voice/waa.ogg'

/datum/chemical_reaction/midnight_tears
	name = "Midnight Tears"
	id = /datum/reagent/consumable/ethanol/midnight_tears
	results = list(/datum/reagent/consumable/ethanol/midnight_tears = 20)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/rum = 3,
		/datum/reagent/consumable/ethanol/curacao = 5,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/sodawater = 15
	)

/datum/chemical_reaction/midnight_sky
	name = "Midnight Sky"
	id = /datum/reagent/consumable/ethanol/midnight_sky
	results = list(/datum/reagent/consumable/ethanol/midnight_sky = 25)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/navy_rum = 3,
		/datum/reagent/consumable/ethanol/curacao = 2,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/space_cola = 15,
		/datum/reagent/consumable/ice = 2
	)

/datum/chemical_reaction/midnight_joy
	name = "Midnight Joy"
	id = /datum/reagent/consumable/ethanol/midnight_joy
	results = list(/datum/reagent/consumable/ethanol/midnight_joy = 25)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/rum = 3,
		/datum/reagent/consumable/pineapplejuice = 5,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/sodawater = 15
	)
