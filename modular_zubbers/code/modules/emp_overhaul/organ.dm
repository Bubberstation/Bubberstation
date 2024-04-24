// https://www.desmos.com/calculator/7sdtn22uda

/obj/item/bodypart/emp_act(severity)

	if(!prob(src.damage*2*(2/severity))) //Chance to get EMP'd is based on self bodypart damage.
		return EMP_PROTECT_ALL

	. = ..()

/obj/item/organ/emp_act(severity) //Internal organs..

	if(src.bodypart_owner && !prob(bodypart_owner.damage*2*(2/severity))) //Chance to get EMP'd is based on attached bodypart damage.
		return EMP_PROTECT_ALL

	. = ..()
