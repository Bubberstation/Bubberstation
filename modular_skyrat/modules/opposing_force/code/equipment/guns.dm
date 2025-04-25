/datum/opposing_force_equipment/ranged
	category = OPFOR_EQUIPMENT_CATEGORY_RANGED
/datum/opposing_force_equipment/ranged/lmg
	name = "L6 SAW LMG"
	description = "A heavily modified 7mm light machine gun, designated 'L6 SAW'. Has 'Aussec Armoury - 2531' engraved on the receiver below the designation."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/lmg

/obj/item/storage/toolbox/guncase/skyrat/opfor/lmg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/l6_saw/unrestricted(src)
	new /obj/item/ammo_box/magazine/m7mm(src)
	new /obj/item/ammo_box/magazine/m7mm(src)

/datum/opposing_force_equipment/ranged/hook_shotgun
	name = "Hook Modified Sawn-off Shotgun"
	description = "Range isn't an issue when you can bring your victim to you."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/hook_shotgun

/obj/item/storage/toolbox/guncase/skyrat/opfor/hook_shotgun/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/hook(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)

/datum/opposing_force_equipment/ranged/rebar_crossbow
	name = "Syndicate Rebar Crossbow"
	description = "The syndicate liked the bootleg rebar crossbow NT engineers made, so they showed what it could be if properly developed. \
			Holds three shots without a chance of exploding, and features a built in scope. Normally uses special syndicate jagged iron bars, but can be wrenched to shoot inferior normal ones."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/rebar_crossbow

/obj/item/storage/toolbox/guncase/skyrat/opfor/rebar_crossbow/PopulateContents()
	new /obj/item/gun/ballistic/rifle/rebarxbow/syndie(src)
	new /obj/item/book/granter/crafting_recipe/dusting/rebarxbowsyndie_ammo(src)

//laser
/datum/opposing_force_equipment/ranged/ion
	name = "ion carbine"
	description = "The MK.II Prototype Ion Projector is a lightweight carbine version of the larger ion rifle, built to be ergonomic and efficient."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/ion

/obj/item/storage/toolbox/guncase/skyrat/opfor/ion/PopulateContents()
	new /obj/item/gun/energy/ionrifle/carbine(src)
	new /obj/item/storage/box/syndie_kit/recharger(src)

/datum/opposing_force_equipment/ranged/carbine
	name = "laser carbine"
	description = "A modified laser gun which can shoot far faster, but each shot is far less damaging."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/carbine

/obj/item/storage/toolbox/guncase/skyrat/opfor/carbine/PopulateContents()
	new /obj/item/gun/energy/laser/carbine(src)
	new /obj/item/storage/box/syndie_kit/recharger(src)

/datum/opposing_force_equipment/ranged/laser
	name = "laser gun"
	description = "A basic energy-based laser gun that fires concentrated beams of light which pass through glass and thin metal."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/laser

/obj/item/storage/toolbox/guncase/skyrat/opfor/laser/PopulateContents()
	new /obj/item/gun/energy/laser(src)
	new /obj/item/storage/box/syndie_kit/recharger(src)

//foamforce
/datum/opposing_force_equipment/ranged/foamforce_lmg
	name = "Foamforce LMG"
	description = "A heavily modified toy light machine gun, designated 'L6 SAW'. Ages 8 and up."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/foamforce_lmg

/obj/item/storage/toolbox/guncase/skyrat/opfor/foamforce_lmg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted/riot(src)
	new /obj/item/ammo_box/magazine/toy/m762/riot(src)
	new /obj/item/ammo_box/magazine/toy/m762/riot(src)


/datum/opposing_force_equipment/ranged_stealth
	category = OPFOR_EQUIPMENT_CATEGORY_RANGED_STEALTH

/datum/opposing_force_equipment/ranged_stealth/rapid_syringe
	name = "Compact Rapid Syringe Gun"
	description = "A modification of the syringe gun design to be more compact and use a rotating cylinder to store up to six syringes."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/rapid_syringe

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/rapid_syringe/PopulateContents()
	new /obj/item/gun/syringe/rapidsyringe(src)
	new /obj/item/storage/belt/medbandolier(src)
	new /obj/item/reagent_containers/syringe/piercing(src)
	new /obj/item/reagent_containers/syringe/piercing(src)
	new /obj/item/reagent_containers/syringe/piercing(src)
	new /obj/item/reagent_containers/syringe/piercing(src)

/datum/opposing_force_equipment/ranged_stealth/c20r
	name = "C-20r SMG"
	description = "A bullpup three-round burst .45 SMG, designated 'C-20r'. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/c20r

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/c20r/PopulateContents()
	new /obj/item/gun/ballistic/automatic/c20r/unrestricted(src)
	new /obj/item/ammo_box/magazine/smgm45(src)
	new /obj/item/ammo_box/magazine/smgm45(src)

/datum/opposing_force_equipment/ranged_stealth/makarov
	name = "Makarov Pistol"
	description = "A small, easily concealable 9x25mm Mk.12 handgun. This one is packed with a suppressor."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/makarov

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/makarov/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol(src)
	new /obj/item/suppressor(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/ammo_box/magazine/m9mm(src)

/datum/opposing_force_equipment/ranged_stealth/m1911
	name = "M1911 Pistol"
	description = "A classic .45 handgun with a small magazine capacity."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/m1911

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/m1911/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m1911(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/datum/opposing_force_equipment/ranged_stealth/syndie_revolver
	name = "Syndicate Revolver"
	description = "A modernized 7 round revolver manufactured by Scarborough."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/syndie_revolver

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/syndie_revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

/datum/opposing_force_equipment/ranged_stealth/ocelot
	name = "Colt Peacemaker revolver"
	admin_note = "Is packed with peacemaker .357, which deals significantly less damage but has a cool ricochet!"
	description = "A modified Peacemaker revolver that chambers .357 ammo. Less powerful than the regular .357, but ricochets a lot more."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/ocelot

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/ocelot/PopulateContents()
	new /obj/item/gun/ballistic/revolver/ocelot(src)
	new /obj/item/ammo_box/a357/peacemaker(src)
	new /obj/item/ammo_box/a357/peacemaker(src)

//foamforce
/datum/opposing_force_equipment/ranged_stealth/foamforce_smg
	name = "Donksoft SMG"
	description = "A bullpup three-round burst toy SMG, designated 'C-20r'. Ages 8 and up."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/foamforce_smg

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/foamforce_smg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot(src)
	new /obj/item/ammo_box/magazine/toy/smgm45/riot(src)
	new /obj/item/ammo_box/magazine/toy/smgm45/riot(src)

/datum/opposing_force_equipment/ranged_stealth/foamforce_smg_basic
	name = "Foamforce SMG"
	description = "A prototype three-round burst toy submachine gun. Ages 8 and up."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/foamforce_smg_basic

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/foamforce_smg_basic/PopulateContents()
	new /obj/item/gun/ballistic/automatic/toy/riot(src)
	new /obj/item/ammo_box/magazine/toy/smg/riot(src)
	new /obj/item/ammo_box/magazine/toy/smg/riot(src)

//laser
/datum/opposing_force_equipment/ranged_stealth/fisher
	item_type = /obj/item/gun/energy/recharge/fisher

/datum/opposing_force_equipment/ranged_stealth/ebow
	item_type = /obj/item/gun/energy/recharge/ebow

/datum/opposing_force_equipment/ranged_stealth/egun_mini
	name = "miniature energy gun"
	description = "A small, pistol-sized energy gun with a built-in flashlight. It has two settings: disable and kill."
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/egun_mini

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/egun_mini/PopulateContents()
	new /obj/item/gun/energy/e_gun/mini(src)
	new /obj/item/storage/box/syndie_kit/recharger(src)
