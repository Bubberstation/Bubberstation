// Pill bottles for synthetic healing medications
/obj/item/storage/pill_bottle/liquid_solder
	name = "bottle of liquid solder pills"
	desc = "Contains pills used to treat synthetic brain damage."
	spawn_type = /obj/item/reagent_containers/applicator/pill/liquid_solder
	spawn_count = 7

// Contains 4 liquid_solder pills instead of 7, and 10u pills instead of 50u.
// 50u pills heal 375 brain damage, 10u pills heal 75.
/obj/item/storage/pill_bottle/liquid_solder/braintumor
	desc = "Contains diluted pills used to treat synthetic brain damage symptoms. Take one when feeling lightheaded."
	spawn_type = /obj/item/reagent_containers/applicator/pill/liquid_solder/braintumor
	spawn_count = 4

/obj/item/storage/pill_bottle/nanite_slurry
	name = "bottle of concentrated nanite slurry pills"
	desc = "Contains nanite slurry pills used for <b>critical system repair</b> to induce an overdose in a synthetic to repair organs."
	spawn_type = /obj/item/reagent_containers/applicator/pill/nanite_slurry
	spawn_count = 5

/obj/item/storage/pill_bottle/system_cleaner
	name = "bottle of system cleaner pills"
	desc = "Contains pills used to detoxify synthetic bodies."
	spawn_type = /obj/item/reagent_containers/applicator/pill/system_cleaner
	spawn_count = 7
