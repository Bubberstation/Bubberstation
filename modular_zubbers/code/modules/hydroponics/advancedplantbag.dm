/datum/storage/adv_plant_bag    //The storage type for the bag below

/datum/storage/adv_plant_bag/remove_single(mob/removing, obj/item/thing, atom/newLoc, silent)
    var/obj/item/resolve_location = real_location?.resolve()
    if(!resolve_location)
        return

    resolve_location.visible_message(span_notice("[removing] reaches inside \the [resolve_location]."),
        span_notice("You reach into \the [resolve_location] to grab something."))
    if(!do_after(removing, 1.5 SECONDS, resolve_location))    //A short period to grab an item to avoid mid-combat abuse, taken from bluespace trash bags.
        return

    return ..()
/obj/item/storage/bag/adv_plant_bag //Plant Bag of Holding
    name = "Plant Bag of Holding"
    icon = 'modular_zubbers/code/modules/hydroponics/icons/adv_plant_bag.dmi'
    icon_state = "advplantbag"
    worn_icon = 'modular_zubbers/code/modules/hydroponics/icons/adv_plant_bag.dmi'
    worn_icon_state = "advplantworn"
    resistance_flags = FLAMMABLE
    slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS    //Yes, this one fits in your pocket!
    storage_type = /datum/storage/adv_plant_bag

/obj/item/storage/bag/adv_plant_bag/Initialize(mapload)
    . = ..()
    atom_storage.max_specific_storage = WEIGHT_CLASS_HUGE
    atom_storage.max_total_storage = 600
    atom_storage.max_slots = 600
    atom_storage.set_holdable(list(
        /obj/item/food/grown,
        /obj/item/graft,
        /obj/item/grown,
        /obj/item/food/honeycomb,
        /obj/item/seeds,
        ))

/datum/design/adv_plant_bag
    name = "Plant Bag of Holding"
    desc = "An advanced plant bag with bluespace properties; capable of holding a whole season's worth of harvests."
    id = "adv_plant_bag"
    build_type = PROTOLATHE | AWAY_LATHE
    materials = list(/datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT*3, /datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT*2)
    build_path = /obj/item/storage/bag/adv_plant_bag
    category = list(
        RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY_ADVANCED
    )
    departmental_flags = DEPARTMENT_BITFLAG_SERVICE
