/obj/item/storage/bag/garment
	name = "garment bag"
	icon = 'icons/obj/storage/storage.dmi'
	icon_state = "garment_bag"
	desc = "A bag for storing extra clothes and shoes."
	slot_flags = NONE
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/garment

/obj/item/storage/bag/garment/captain
	name = "captain's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the captain."

/obj/item/storage/bag/garment/hos
	name = "head of security's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the head of security."

/obj/item/storage/bag/garment/warden
	name = "warden's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the warden."

/obj/item/storage/bag/garment/hop
	name = "head of personnel's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the head of personnel."

/obj/item/storage/bag/garment/research_director
	name = "research director's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the research director."

/obj/item/storage/bag/garment/chief_medical
	name = "chief medical officer's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the chief medical officer."

/obj/item/storage/bag/garment/engineering_chief
	name = "chief engineer's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the chief engineer."

/obj/item/storage/bag/garment/quartermaster
	name = "quartermasters's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the quartermaster."

/obj/item/storage/bag/garment/paramedic
	name = "EMT's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the emergency medical team."

/obj/item/storage/bag/garment/captain/PopulateContents()
	new /obj/item/clothing/under/rank/captain(src)
	new /obj/item/clothing/under/rank/captain/skirt(src)
	new /obj/item/clothing/under/rank/captain/parade(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace/captains_formal(src)
	new /obj/item/clothing/suit/hooded/wintercoat/captain(src)
	new /obj/item/clothing/suit/jacket/capjacket(src)
	new /obj/item/clothing/glasses/sunglasses/gar/giga(src)
	new /obj/item/clothing/gloves/captain(src)
	new /obj/item/clothing/head/costume/crown/fancy(src)
	new /obj/item/clothing/head/hats/caphat(src)
	new /obj/item/clothing/head/hats/caphat/parade(src)
	new /obj/item/clothing/neck/cloak/cap(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/storage/backpack/captain(src)
	new /obj/item/storage/backpack/satchel/cap(src)
	new /obj/item/storage/backpack/duffelbag/captain(src)
	new /obj/item/storage/backpack/messenger/cap(src)

/obj/item/storage/bag/garment/hop/PopulateContents()
	new /obj/item/clothing/under/rank/civilian/head_of_personnel(src)
	new /obj/item/clothing/under/rank/civilian/head_of_personnel/skirt(src)
	new /obj/item/clothing/suit/armor/vest/hop(src)
	new /obj/item/clothing/suit/hooded/wintercoat/hop(src)
	//new /obj/item/clothing/glasses/sunglasses(src) //BUBBER REMOVAL - They get civhuds by override in modular file
	new /obj/item/clothing/head/hats/hopcap(src)
	new /obj/item/clothing/neck/cloak/hop(src)
	new /obj/item/clothing/shoes/laceup(src)
//Duplication from Commdrobe
	new /obj/item/clothing/head/playbunnyears/hop(src)
	new /obj/item/clothing/under/rank/civilian/hop_bunnysuit(src)
	new /obj/item/clothing/suit/armor/hop_tailcoat(src)
	new /obj/item/clothing/neck/tie/bunnytie/hop(src)
	new /obj/item/clothing/head/hopcap/beret(src)
	new /obj/item/clothing/head/hopcap/beret/alt(src)
	new /obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck(src)
	new /obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck/skirt(src)
	new /obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade(src)
	new /obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade/female(src)
	new /obj/item/clothing/suit/armor/vest/hop/hop_formal(src)
	new /obj/item/clothing/neck/mantle/hopmantle(src)

/obj/item/storage/bag/garment/hos/PopulateContents()
	new /obj/item/clothing/under/rank/security/head_of_security/skirt(src)
	new /obj/item/clothing/under/rank/security/head_of_security/alt(src)
	new /obj/item/clothing/under/rank/security/head_of_security/alt/skirt(src)
	new /obj/item/clothing/under/rank/security/head_of_security/grey(src)
	new /obj/item/clothing/under/rank/security/head_of_security/parade(src)
	new /obj/item/clothing/under/rank/security/head_of_security/parade/female(src)
	new /obj/item/clothing/gloves/tackler/combat(src)
	new /obj/item/clothing/suit/armor/hos(src)
	new /obj/item/clothing/suit/armor/hos/hos_formal(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat/winter(src)
	new /obj/item/clothing/suit/armor/vest/leather(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/gars/giga(src)
	new /obj/item/clothing/head/hats/hos/beret(src)
	new /obj/item/clothing/head/hats/hos/cap(src)
	new /obj/item/clothing/mask/gas/sechailer/swat(src)
	new /obj/item/clothing/neck/cloak/hos(src)
//BUBBER ADDITION BEGIN
	new /obj/item/clothing/neck/cloak/hos/redsec(src)
	new /obj/item/clothing/under/rank/security/head_of_security/redsec(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec(src)
	new /obj/item/clothing/shoes/jackboots/sec/redsec(src)
	new /obj/item/clothing/head/hos_kepi(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/skirt_hos(src)
//BUBBER ADDITION END
//Duplication from Commdrobe
	new /obj/item/clothing/head/hats/warden/drill/hos(src)
	new	/obj/item/clothing/under/rank/security/head_of_security/alt/roselia(src)
	new	/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia(src)
	new	/obj/item/clothing/under/rank/security/head_of_security/parade/redsec(src)
	new	/obj/item/clothing/under/rank/security/head_of_security/parade/female/redsec(src)
	new	/obj/item/clothing/head/hats/hos/elofy(src)
	new	/obj/item/clothing/suit/armor/hos/elofy(src)
	new	/obj/item/clothing/gloves/elofy(src)
	new	/obj/item/clothing/shoes/jackboots/elofy(src)
	new	/obj/item/clothing/head/playbunnyears/hos(src)
	new	/obj/item/clothing/under/rank/security/head_of_security/bunnysuit(src)
	new	/obj/item/clothing/suit/armor/hos_tailcoat(src)
	new /obj/item/clothing/head/hats/hos/beret/navyhos(src)
	new /obj/item/clothing/under/rank/security/head_of_security/peacekeeper(src)
	new /obj/item/clothing/suit/jacket/hos/blue(src)
	new /obj/item/clothing/neck/mantle/hosmantle(src)

/obj/item/storage/bag/garment/warden/PopulateContents()
	new /obj/item/clothing/suit/armor/vest/warden(src)
	new /obj/item/clothing/head/hats/warden(src)
	new /obj/item/clothing/head/hats/warden/drill(src)
	new /obj/item/clothing/head/beret/sec/navywarden(src)
	new /obj/item/clothing/suit/armor/vest/warden/alt(src)
	new /obj/item/clothing/under/rank/security/warden/formal(src)
	new /obj/item/clothing/suit/jacket/warden/blue(src) //SKYRAT ADDITION - FORMAL COAT
	new /obj/item/clothing/under/rank/security/warden/skirt(src)
	new /obj/item/clothing/gloves/kaza_ruk/sec(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/clothing/mask/gas/sechailer(src)

/obj/item/storage/bag/garment/research_director/PopulateContents()
	new /obj/item/clothing/under/rank/rnd/research_director(src)
	new /obj/item/clothing/under/rank/rnd/research_director/skirt(src)
	new /obj/item/clothing/under/rank/rnd/research_director/alt(src)
	new /obj/item/clothing/under/rank/rnd/research_director/alt/skirt(src)
	new /obj/item/clothing/under/rank/rnd/research_director/turtleneck(src)
	new /obj/item/clothing/under/rank/rnd/research_director/turtleneck/skirt(src)
	new /obj/item/clothing/suit/toggle/labcoat/skyrat/rd(src) //SKYRAT EDIT ADDITION
	new /obj/item/clothing/suit/hooded/wintercoat/science/rd(src)
	new /obj/item/clothing/head/beret/science/rd(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/neck/cloak/rd(src)
	new /obj/item/clothing/shoes/jackboots(src)
//Duplication from Commdrobe
	new /obj/item/clothing/head/beret/science/rd(src)
	new /obj/item/clothing/head/beret/science/rd/alt(src)
	new /obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit(src)
	new /obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit/skirt(src)
	new /obj/item/clothing/neck/mantle/rdmantle(src)
	new /obj/item/clothing/suit/toggle/labcoat(src)
	new /obj/item/clothing/suit/toggle/labcoat/research_director(src)
	new	/obj/item/clothing/head/playbunnyears/rd(src)
	new /obj/item/clothing/under/rank/rnd/research_director/bunnysuit(src)
	new /obj/item/clothing/suit/toggle/labcoat/research_director/tailcoat(src)
	new /obj/item/clothing/neck/tie/bunnytie/rd(src)


/obj/item/storage/bag/garment/chief_medical/PopulateContents()
	new /obj/item/clothing/under/rank/medical/chief_medical_officer(src)
	new /obj/item/clothing/under/rank/medical/chief_medical_officer/skirt(src)
	new /obj/item/clothing/under/rank/medical/chief_medical_officer/scrubs(src)
	new /obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck(src)
	new /obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck/skirt(src)
	new /obj/item/clothing/suit/hooded/wintercoat/medical/cmo(src)
	new /obj/item/clothing/suit/toggle/labcoat/cmo(src)
	new /obj/item/clothing/gloves/latex/nitrile(src)
	new /obj/item/clothing/head/beret/medical/cmo(src)
	new /obj/item/clothing/head/utility/surgerycap/cmo(src)
	new /obj/item/clothing/neck/cloak/cmo(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/storage/backpack/chief_medic(src)
	new /obj/item/storage/backpack/satchel/chief_medic(src)
	new /obj/item/storage/backpack/duffelbag/chief_medic(src)
	new /obj/item/storage/backpack/messenger/chief_medic(src)
//Duplication from Commdrobe
	new /obj/item/clothing/head/beret/medical/cmo/alt(src)
	new /obj/item/clothing/neck/mantle/cmomantle(src)
	new /obj/item/clothing/head/playbunnyears/cmo(src)
	new /obj/item/clothing/under/rank/medical/cmo_bunnysuit(src)
	new /obj/item/clothing/suit/toggle/labcoat/cmo/doctor_tailcoat(src)
	new /obj/item/clothing/neck/tie/bunnytie/cmo(src)

/obj/item/storage/bag/garment/engineering_chief/PopulateContents()
	new /obj/item/clothing/under/rank/engineering/chief_engineer(src)
	new /obj/item/clothing/under/rank/engineering/chief_engineer/skirt(src)
	new /obj/item/clothing/under/rank/engineering/chief_engineer/turtleneck(src)
	new /obj/item/clothing/under/rank/engineering/chief_engineer/turtleneck/skirt(src)
	new /obj/item/clothing/suit/hooded/wintercoat/engineering/ce(src)
	new /obj/item/clothing/glasses/meson/engine(src)
	new /obj/item/clothing/gloves/chief_engineer(src)
	new /obj/item/clothing/head/utility/hardhat/white(src)
	new /obj/item/clothing/head/utility/hardhat/welding/white(src)
	new /obj/item/clothing/neck/cloak/ce(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
//Duplication from Commdrobe
	new /obj/item/clothing/head/beret/engi/ce(src)
	new /obj/item/clothing/neck/mantle/cemantle(src)
	new /obj/item/clothing/head/playbunnyears/ce(src)
	new /obj/item/clothing/under/rank/engineering/chief_engineer/bunnysuit(src)
	new /obj/item/clothing/suit/utility/fire/ce_tailcoat(src)
	new /obj/item/clothing/neck/tie/bunnytie/ce(src)

/obj/item/storage/bag/garment/quartermaster/PopulateContents()
	new /obj/item/clothing/under/rank/cargo/qm(src)
	new /obj/item/clothing/under/rank/cargo/qm/skirt(src)
	new /obj/item/clothing/suit/hooded/wintercoat/cargo/qm(src)
	new /obj/item/clothing/suit/utility/fire/firefighter(src)
	new /obj/item/clothing/gloves/fingerless(src)
	new /obj/item/clothing/suit/jacket/quartermaster(src)
	new /obj/item/clothing/head/soft(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/neck/cloak/qm(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
//Duplication from Comdrobe
	new /obj/item/clothing/head/beret/cargo/qm(src)
	new /obj/item/clothing/head/beret/cargo/qm/alt(src)
	new /obj/item/clothing/neck/mantle/qm(src)
	new /obj/item/clothing/under/rank/cargo/qm/skyrat/gorka(src)
	new /obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck(src)
	new /obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck/skirt(src)
	new /obj/item/clothing/suit/brownfurrich(src)
	new /obj/item/clothing/under/rank/cargo/qm/skyrat/casual(src)
	new /obj/item/clothing/suit/toggle/jacket/supply/head(src)
	new /obj/item/clothing/under/rank/cargo/qm/skyrat/formal(src)
	new /obj/item/clothing/under/rank/cargo/qm/skyrat/formal/skirt(src)
	new /obj/item/clothing/head/playbunnyears/quartermaster(src)
	new /obj/item/clothing/under/rank/cargo/quartermaster_bunnysuit(src)
	new /obj/item/clothing/suit/jacket/tailcoat/quartermaster(src)
	new /obj/item/clothing/neck/tie/bunnytie/cargo(src)


/obj/item/storage/bag/garment/paramedic/PopulateContents()
	new /obj/item/clothing/under/rank/medical/paramedic(src)
	new /obj/item/clothing/under/rank/medical/paramedic/skirt(src)
	new /obj/item/clothing/gloves/latex/nitrile(src)
	new /obj/item/clothing/shoes/workboots/black(src)
	new /obj/item/clothing/glasses/hud/health(src)
