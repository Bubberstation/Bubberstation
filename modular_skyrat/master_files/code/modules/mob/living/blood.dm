/// Accessor for the monkey_blood field in the blood data list.
#define MONKEY_ORIGINS "monkey_origins"

// This is the additional code to handle blood originating from monkeys, to make it so
// there's a way to track if blood was extracted from a monkey or not.
/mob/living/carbon/get_blood_data(blood_id)
	. = ..()
	.[MONKEY_ORIGINS] = ismonkey(src)

/datum/element/blood_reagent/on_merge(datum/reagent/source, list/mix_data, amount)
	. = ..()
	if(source.data && mix_data)
		source.data[MONKEY_ORIGINS] = source.data[MONKEY_ORIGINS] || mix_data[MONKEY_ORIGINS]

#undef MONKEY_ORIGINS
