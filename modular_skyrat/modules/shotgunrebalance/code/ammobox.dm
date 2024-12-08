/obj/item/ammo_box/advanced/s12gauge
	name = "Slug ammo box"
	desc = "A box of 7 slug shells. Large, singular shots that pack a punch."
	icon = 'modular_skyrat/modules/shotgunrebalance/icons/shotbox.dmi'
	icon_state = "slug"
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 7
	multitype = FALSE // if you enable this and set the box's caliber var to CALIBER_SHOTGUN (at time of writing, "shotgun"), then you can have the fabled any-ammo shellbox

	custom_premium_price = 500

/obj/item/ammo_box/advanced/s12gauge/laser
	name = "Scatterlaser ammo box"
	desc = "A box of 7 laser shells. Fires highly lethal laser shell."
	icon_state = "laser"
	ammo_type = /obj/item/ammo_casing/shotgun/scatterlaser

/obj/item/ammo_box/advanced/s12gauge/buckshot
	name = "Buckshot ammo box"
	desc = "A box of 7 buckshot shells. These have a modest spread of weaker projectiles."
	icon_state = "buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/advanced/s12gauge/rubber
	name = "Rubbershot ammo box"
	desc = "A box of 7 rubbershot shells. These have a modest spread of weaker, less-lethal projectiles."
	icon_state = "rubber"
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/advanced/s12gauge/bean
	name = "Beanbag Slug ammo box"
	desc = "A box of 7 beanbag slug shells. These are large, singular beanbags that pack a less-lethal punch."
	icon_state = "bean"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/advanced/s12gauge/magnum
	name = "Magnum buckshot ammo box"
	desc = "A box of 7 magnum buckshot shells. The size of the pellet is larger in diameter than the typical shot, but there are less of them inside each shell."
	icon_state = "magnum"
	ammo_type = /obj/item/ammo_casing/shotgun/magnum

/obj/item/ammo_box/advanced/s12gauge/express
	name = "Express pelletshot ammo box"
	desc = "A box of 7 express pelletshot shells. The size of the pellet is smaller in diameter than the typical shot, but there are more of them inside each shell."
	icon_state = "express"
	ammo_type = /obj/item/ammo_casing/shotgun/express

/obj/item/ammo_box/advanced/s12gauge/hunter
	name = "Hunter slug ammo box"
	desc = "A box of 7 hunter slug shells. These shotgun slugs excel at damaging the local fauna."
	icon_state = "hunter"
	ammo_type = /obj/item/ammo_casing/shotgun/hunter

/obj/item/ammo_box/advanced/s12gauge/flechette
	name = "Flechette ammo box"
	desc = "A box of 7 flechette shells. Each shell contains a small group of tumbling blades that excel at causing terrible wounds."
	icon_state = "flechette"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette

/obj/item/ammo_box/advanced/s12gauge/dragonsbreath
	name = "Dragon's breath ammo box"
	desc = "A box of 7 Dragon's breath shells. Each shell contains plasma inside to create a massive trailing flame, excel at collateral damage."
	icon_state = "dragonsbreath"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/advanced/s12gauge/beehive
	name = "Hornet's nest ammo box"
	desc = "A box of 7 hornet's nest shells. These are less-lethal shells that will bounce off walls and direct themselves toward nearby targets."
	icon_state = "beehive"
	ammo_type = /obj/item/ammo_casing/shotgun/beehive

/obj/item/ammo_box/advanced/s12gauge/antitide
	name = "Stardust ammo box"
	desc = "A box of 7 advanced anti riot shells. These are less-lethal and will embed in targets, causing pain on movement."
	icon_state = "antitide"
	ammo_type = /obj/item/ammo_casing/shotgun/antitide

/obj/item/ammo_box/advanced/s12gauge/incendiary
	name = "Incendiary Slug ammo box"
	desc = "A box of 7 incendiary slug shells. These will ignite targets and leave a trail of fire behind them."
	icon_state = "incendiary"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary

/obj/item/ammo_box/advanced/s12gauge/honkshot
	name = "Confetti Honkshot ammo box"
	desc = "A box of 7 honkshot shotgun shells. These are filled with confetti and sure to make any party go out with a bang!"
	icon_state = "honk"
	ammo_type = /obj/item/ammo_casing/shotgun/honkshot

/obj/item/ammo_box/advanced/s12gauge/frangible
	name = "Frangible Slug ammo box"
	desc = "A box of 7 Frangible slug. It's able to punches through windows, airlocks whatever with ease. Less-than-effective against people"
	icon_state = "fslug"
	ammo_type = /obj/item/ammo_casing/shotgun/frangible

//The one below here has a destruction damage of 200, it two shot most mech, use the one above
/obj/item/ammo_box/advanced/s12gauge/breaching
	name = "Breaching Slug ammo box"
	desc = "A box of 7 Breaching slug. It's able to punches through- quite literally anything with ease."
	icon_state = "fslug"
	ammo_type = /obj/item/ammo_casing/shotgun/breacher

//This is intended for ERT! Have fun with it
/obj/item/ammo_box/advanced/s12gauge/pulse
	name = "Pulse Slug ammo box"
	desc = "A box of 7 Pulse slug. It's able to punches through structures and anything behind it."
	icon_state = "pulse"
	ammo_type = /obj/item/ammo_casing/shotgun/pulseslug

/obj/item/ammo_box/advanced/s12gauge/scatterion
	name = "Scatter Ion ammo box"
	desc = "A box of 7 Scatter ion. I hope you have no cybernetic organs."
	icon_state = "pulse"
	ammo_type = /obj/item/ammo_casing/shotgun/ion
