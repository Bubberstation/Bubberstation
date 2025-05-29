////////////////////////////////////////////////////////////////////////////////
/// GS13 - big bottles
////////////////////////////////////////////////////////////////////////////////

//unfortunately I wasn't able to code in a fancy overlay that changes depending on bottle's contents volume
//however if anyone would like to give it a go, the sprites for it are already there, in the .dmi

/obj/item/reagent_containers/food/drinks/bigbottle
	name = "Bottle"
	desc = "You shouldn't see this."
	icon = 'GainStation13/icons/obj/food/bigbottle.dmi'
	icon_state = "bigbottle_default"
	list_reagents = list(/datum/reagent/consumable/space_cola = 25)
	custom_materials = list(/datum/material/plastic=200)
	foodtype = SUGAR
	isGlass = FALSE
	volume = 100

/obj/item/reagent_containers/food/drinks/bigbottle/starkist
	name = "StarKist Bottle"
	desc = "A big bottle of Sunkist - for all your chuggin' needs."
	icon_state = "bigbottle_fan"
	list_reagents = list(/datum/reagent/consumable/sodawater = 20, /datum/reagent/consumable/orangejuice = 60)

/obj/item/reagent_containers/food/drinks/bigbottle/cola
	name = "GT-Cola Bottle"
	desc = "A big bottle of GT-Cola - for all your chuggin' needs."
	icon_state = "bigbottle_cola"
	list_reagents = list(/datum/reagent/consumable/space_cola = 80)

/obj/item/reagent_containers/food/drinks/bigbottle/spaceup
	name = "Space-Up! Bottle"
	desc = "A big bottle of Space-Up! - for all your chuggin' needs."
	icon_state = "bigbottle_spr"
	list_reagents = list(/datum/reagent/consumable/space_up = 60, /datum/reagent/consumable/sodawater = 20)

/obj/item/reagent_containers/food/drinks/bigbottle/fizz
	name = "Fizz-Wizz Bottle"
	desc = "A big bottle of Fizz-Wizz - for all your chuggin' needs."
	icon_state = "bigbottle_fizz"
	list_reagents = list(/datum/reagent/consumable/space_cola = 50, /datum/reagent/consumable/fizulphite = 30)


//code for overlays
/obj/item/reagent_containers/food/drinks/bigbottle/on_reagent_change()
  cut_overlays()
  var/mutable_appearance/reagent_overlay = mutable_appearance(icon, "reagent")
  if(reagents.reagent_list.len)
    /*if(!renamedByPlayer)
      name = "bottle of " + R.name
      desc = R.glass_desc*/

    var/percent = round((reagents.total_volume / volume) * 100)
    switch(percent)
      if(0)
        reagent_overlay.icon_state = "reagent0"
      if(1 to 19)
        reagent_overlay.icon_state = "reagent20"
      if(20 to 39)
        reagent_overlay.icon_state = "reagent40"
      if(40 to 59)
        reagent_overlay.icon_state = "reagent60"
      if(60 to 79)
        reagent_overlay.icon_state = "reagent80"
      if(80 to 100)
        reagent_overlay.icon_state = "reagent100"
    reagent_overlay.color = mix_color_from_reagents(reagents.reagent_list)
    add_overlay(reagent_overlay)
  else
    reagent_overlay.icon_state = "reagent0"
  add_overlay(reagent_overlay)
