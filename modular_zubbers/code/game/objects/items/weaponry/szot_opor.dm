// Szot Dynamica's officer sidearm for when the shooting has stopped being useful.
// Runs off a replaceable cell, which is the whole point of it.

/// A full trip around the hue wheel in even steps, which reads far smoother than the stock twelve frames
GLOBAL_LIST_INIT(opor_rainbow, list(
	"#FF0000", "#FF4000", "#FF8000", "#FFBF00", "#FFFF00", "#BFFF00",
	"#80FF00", "#40FF00", "#00FF00", "#00FF40", "#00FF80", "#00FFBF",
	"#00FFFF", "#00BFFF", "#0080FF", "#0040FF", "#0000FF", "#4000FF",
	"#8000FF", "#BF00FF", "#FF00FF", "#FF00BF", "#FF0080", "#FF0040",
))

/// Energy drawn per swing, matching the security stun baton exactly: one standard cell charge a hit,
/// shipping with the same high cell it uses. Ten swings out of the box, more once upgraded.
#define OPOR_HIT_COST STANDARD_CELL_CHARGE
/// Multiplier applied to that cost once the warranty has been voided
#define OPOR_OVERCLOCK_DRAW 1.5
/// How long a full colour cycle takes in rainbow mode
#define OPOR_RGB_CYCLE_TIME (4 SECONDS)

/obj/item/melee/energy/sword/opor
	resistance_flags = INDESTRUCTIBLE
	name = "\improper Opór Energy Sword"
	desc = "An old Szot Dynamica military energy sword, recognizable by its green beam and replaceable power cell. \
		Though eclipsed by newer designs in raw damage and efficiency, the Opór remains every bit as dangerous as its \
		reputation suggests. Etching on the hilt reads \"Za wolność naszą i waszą\", \"For our freedom and yours.\""
	icon = 'modular_zubbers/icons/obj/szot_opor.dmi'
	icon_state = "opor"
	base_icon_state = "opor"
	greyscale_config = /datum/greyscale_config/szot_opor
	greyscale_colors = "#83825E#00FF00#CD4456"
	greyscale_config_inhand_left = /datum/greyscale_config/szot_opor/lefthand
	greyscale_config_inhand_right = /datum/greyscale_config/szot_opor/righthand
	inhand_icon_state = "opor"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	sword_color_icon = null
	// benchmarked against the shamshir sabre cargo can already buy (force 15, ap 25, wound 5, block 20).
	// the Opór trades that sword's armour penetration and wounding for raw damage and a better parry,
	// and pays for both with a power cell. competitive with it, dominant over nothing.
	active_force = 18
	armour_penetration = 10
	block_chance = 30
	active_heat = 0
	slot_flags = ITEM_SLOT_BELT
	// the esword is small enough to pocket; this one is a proper hilt and belongs on a belt
	w_class = WEIGHT_CLASS_NORMAL
	// borrowed from the surplus sword: without a worn state the belt slot draws a missing texture
	worn_icon_state = "energysurplus"
	// 20 exposed is the standard across every energy weapon in the game, so it stays.
	// the flat bonus sits at 5: above a combat knife, below the sabre, the shamshir and the scythe.
	wound_bonus = 5
	// the inherited 1.5 took a window down in five swings, and 0.6 could never finish one at all.
	// 0.9 gets through a crate with patience and a window with rather more of it.
	demolition_mod = 0.9
	/// The cell keeping the emitter fed
	var/obj/item/stock_parts/power_store/cell/cell
	/// Has somebody taken a screwdriver and a poor attitude to the regulator
	var/overclocked = FALSE
	/// Is the blade cycling colours
	var/rainbow = FALSE
	/// The colours to fall back to when the rainbow cycle stops, captured from whatever it is wearing
	var/list/resting_colours

/obj/item/melee/energy/sword/opor/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/power_store/cell/high(src)
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddElement(/datum/element/gags_recolorable)
	resting_colours = greyscale_colors
	sync_blade_light()

/obj/item/melee/energy/sword/opor/Destroy()
	QDEL_NULL(cell)
	return ..()

/obj/item/melee/energy/sword/opor/update_overlays()
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return
	if(rainbow)
		// the blade layer is covered exactly, so the hilt below keeps its own colours
		. += mutable_appearance('modular_zubbers/icons/obj/szot_opor.dmi', "opor_blade_rainbow")
		. += emissive_appearance('modular_zubbers/icons/obj/szot_opor.dmi', "opor_blade_rainbow", src, alpha = 200)
		return
	. += emissive_appearance(icon, "[base_icon_state]_on-emissive", src, alpha = 200)

/obj/item/melee/energy/sword/opor/examine(mob/user)
	. = ..()
	. += span_notice("The power cell reads [cell ? "[round(cell.percent())]%" : "empty"]. It can be <b>screwed</b> out.")
	if(overclocked)
		. += span_warning("The regulator has been bypassed. It draws power far faster than it ought to.")

/obj/item/melee/energy/sword/opor/examine_more(mob/user)
	. = ..()

	. += "The 'Opór' entered service during a period in which the states that would later form the CIN were still \
		defining themselves through resistance to foreign domination, corporate interference, and the considerably \
		better armed people who tended to accompany both. Szot Dynamica's original proposal was unusually dry, \
		describing a compact close-combat energy weapon for officers, boarding parties, and personnel expected to \
		continue fighting after the loss of conventional arms. CIN propagandists were rather more enthusiastic. By the \
		time the Opór entered widespread service, recruiting material had taken to describing it as a sword for \
		soldiers who could not afford the luxury of surrender."

	. += "For its time, the design was exceptional. A self-contained emitter and replaceable power cell allowed the \
		Opór to deliver a full-strength energy blade from a package small enough to wear at the hip. Modern weapons \
		have since surpassed it through advances in compact power generation and exotic emitter materials, but while \
		the design eventually left frontline service, large numbers survived in arsenals, ceremonial collections, and \
		later military-surplus markets; and those developments did not make the antiques floating around the second \
		hand market any less deadly. Many are still maintained today, helped by Szot's unusually stubborn insistence \
		on user replaceable components wherever possible."

	. += "Its name means 'resistance'. Old CIN recruiting material preferred a more elaborate interpretation: \
		resistance to invasion, resistance to tyranny, and resistance to the suggestion that circumstances had \
		already decided the outcome."

	return .

/// Power drawn for one swing, accounting for a bypassed regulator
/obj/item/melee/energy/sword/opor/proc/swing_cost()
	return overclocked ? OPOR_HIT_COST * OPOR_OVERCLOCK_DRAW : OPOR_HIT_COST

/obj/item/melee/energy/sword/opor/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) && !cell?.use(swing_cost()))
		balloon_alert(user, "cell dead!")
		attack_self(user)
		return TRUE
	return ..()

/obj/item/melee/energy/sword/opor/attack_atom(atom/attacked_atom, mob/living/user, list/modifiers, list/attack_modifiers)
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) && !cell?.use(swing_cost()))
		balloon_alert(user, "cell dead!")
		attack_self(user)
		return TRUE
	return ..()

/obj/item/melee/energy/sword/opor/attack_self(mob/user)
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) && (!cell || cell.charge < swing_cost()))
		balloon_alert(user, "no charge!")
		return
	return ..()

/obj/item/melee/energy/sword/opor/dropped(mob/user, silent)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		attack_self(user)

/obj/item/melee/energy/sword/opor/screwdriver_act(mob/living/user, obj/item/tool)
	if(!cell)
		balloon_alert(user, "no cell!")
		return ITEM_INTERACT_BLOCKING
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		balloon_alert(user, "switch it off first!")
		return ITEM_INTERACT_BLOCKING
	user.put_in_hands(cell)
	cell = null
	balloon_alert(user, "cell removed")
	tool.play_tool_sound(src)
	return ITEM_INTERACT_SUCCESS

/// A fresh cell only goes in through an opened housing, so nobody is swapping one mid-fight
/obj/item/melee/energy/sword/opor/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return ..()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		balloon_alert(user, "switch it off first!")
		return ITEM_INTERACT_BLOCKING
	if(cell)
		balloon_alert(user, "unscrew the old one first!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	cell = tool
	balloon_alert(user, "cell installed")
	playsound(src, 'sound/machines/click.ogg', 40, TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/energy/sword/opor/build_worn_icon(
	default_layer = 0,
	default_icon_file = null,
	isinhands = FALSE,
	female_uniform = NO_FEMALE_UNIFORM,
	override_state = null,
	override_file = null,
	bodyshape = NONE,
	mutant_styles = NONE,
)
	. = ..()
	if(!isinhands || !rainbow || !HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return
	// build_worn_icon returns a single appearance, not a list, so the arc rides as an overlay on it
	var/mutable_appearance/worn = .
	if(isnull(worn))
		return
	var/icon/hand_sheet = (default_icon_file == righthand_file) ? righthand_file : lefthand_file
	worn.overlays += mutable_appearance(hand_sheet, "opor_blade_rainbow", default_layer)
	worn.overlays += emissive_appearance(hand_sheet, "opor_blade_rainbow", src, default_layer, alpha = 200)

/obj/item/melee/energy/sword/opor/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!rainbow)
		resting_colours = greyscale_colors
	sync_blade_light()
	update_appearance()

/// The glow takes the blade colour rather than a hardcoded green
/obj/item/melee/energy/sword/opor/proc/sync_blade_light()
	set_light_color(blade_colour())

/obj/item/melee/energy/sword/opor/multitool_act(mob/living/user, obj/item/tool)
	rainbow = !rainbow
	balloon_alert(user, rainbow ? "RNBW_ENGAGE" : "RNBW_DISENGAGE")
	update_blade_colour()
	return ITEM_INTERACT_SUCCESS

/// The sword itself always stays greyscale, so the hilt keeps whatever the owner painted it.
/// Rainbow mode lays a pre-rendered blade-only animation over the top, plus a matching emissive.
/// Nothing is generated at runtime; the frames already exist on the sheets.
/obj/item/melee/energy/sword/opor/proc/update_blade_colour()
	if(!rainbow || !HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		sync_blade_light()
	else
		set_light_color(COLOR_WHITE)
	update_appearance()
	var/mob/holder = loc
	if(ismob(holder))
		holder.update_held_items()

/// Whatever the blade slider is currently set to
/obj/item/melee/energy/sword/opor/proc/blade_colour()
	var/list/parts = splittext(greyscale_colors, "#")
	return length(parts) >= 3 ? "#[parts[3]]" : COLOR_LIME

/obj/item/melee/energy/sword/opor/on_transform(obj/item/source, mob/user, active)
	. = ..()
	update_blade_colour()

/obj/item/melee/energy/sword/opor/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(overclocked)
		balloon_alert(user, "already bypassed!")
		return FALSE
	overclocked = TRUE
	wound_bonus = 15
	balloon_alert(user, "regulator bypassed")
	to_chat(user, span_warning("WARNING: emitter regulator bypassed. Output limiter disengaged. This voids your \
		warranty, and probably several treaties."))
	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 40, TRUE)
	return TRUE

#undef OPOR_HIT_COST
#undef OPOR_OVERCLOCK_DRAW
#undef OPOR_RGB_CYCLE_TIME

// Something the quartermaster's predecessor left in the case, or claims to have.

/obj/item/clothing/head/beret/szot_surplus
	name = "surplus officer's beret"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	desc = "A once noble beret that may or may not have commanded respect and authority at some point \
		from the CIN, or was it the NRI? Oh who remembers..?"
	greyscale_colors = "#2E2E33#9A9AA2"
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/head/beret/szot_surplus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)

/obj/item/clothing/head/beret/szot_surplus/examine_more(mob/user)
	. = ..()

	. += "The Coalition of Independent Nations was never a single army, and its surplus is a museum of \
		half-remembered quartermasters. Berets like this one turn up in crate after crate of it, missing \
		their insignia, sized for nobody in particular, and claimed by every veteran who sees one."

	. += "The seller will tell you it is CIN. The next seller will tell you it is New Russian, and produce \
		a stitching pattern to prove it. Both are confident. Neither has any paperwork."

	return .
