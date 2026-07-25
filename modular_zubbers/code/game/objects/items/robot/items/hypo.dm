#define BASE_CENTCOM_REAGENTS list(\
		/datum/reagent/medicine/c2/aiuri,\
		/datum/reagent/medicine/c2/libital,\
		/datum/reagent/medicine/epinephrine,\
)

/obj/item/reagent_containers/borghypo/centcom
	name = "Basic Injector"
	desc = "Provides basic medical assistance."
	default_reagent_types = BASE_CENTCOM_REAGENTS

#undef BASE_CENTCOM_REAGENTS
