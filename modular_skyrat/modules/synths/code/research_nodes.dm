/datum/techweb_node/improved_robotic_tend_wounds
	id = TECHWEB_NODE_ROBOTIC_SURGERY
	display_name = "Improved Robotic Repair Surgeries"
	description = "As it turns out, you don't actually need to cut out entire support rods if it's just scratched!"
	prereq_ids = list(TECHWEB_NODE_CONSTRUCTION)
	design_ids = list(
		"synthetic_surgery_heal_combo",
		"synthetic_surgery_heal_upgrade",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	required_experiments = list(/datum/experiment/scanning/people/augmented_organs)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/advanced_robotic_tend_wounds
	id = TECHWEB_NODE_ROBOTIC_SURGERY_ADVANCED
	display_name = "Advanced Robotic Surgeries"
	description = "Did you know Hephaestus actually has a free online tutorial for synthetic trauma repairs? It's true!"
	prereq_ids = list(TECHWEB_NODE_ROBOTIC_SURGERY)
	design_ids = list(
		"synthetic_surgery_heal_combo_upgrade",
		"synthetic_surgery_heal_combo_upgrade_femto",
		"synthetic_surgery_heal_upgrade_femto"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/scanning/people/android = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/**
 * Wound tending
 */

// basic
/datum/design/surgery/tend_wounds_upgrade/synth
	name = "Structural Repairs Upgrade"
	desc = "Upgrade the efficiency of the individual tend wound operations."
	id = "synthetic_surgery_heal_upgrade"
	surgery = /datum/surgery_operation/basic/repair_synth/upgraded
	research_icon_state = "surgery_chest"

/datum/design/surgery/tend_wounds_upgrade/synth/femto
	name = "Structural Repairs Upgrade"
	surgery = /datum/surgery_operation/basic/repair_synth/upgraded/master
	id = "synthetic_surgery_heal_upgrade_femto"

// combo
/datum/design/surgery/tend_wounds_combo/synth
	name = "Structural Repairs Combo"
	desc = "An alternative wound treatment operation that treats both bruises and burns at the same time, albeit less effectively than their individual counterparts."
	surgery = /datum/surgery_operation/basic/tend_wounds/combo/synth
	id = "synthetic_surgery_heal_combo"
	research_icon_state = "surgery_chest"

/datum/design/surgery/tend_wounds_combo/synth/upgrade
	name = "Structural Repairs Combo Upgrade"
	surgery = /datum/surgery_operation/basic/tend_wounds/combo/synth/upgraded
	id = "synthetic_surgery_heal_combo_upgrade"

/datum/design/surgery/tend_wounds_combo/synth/upgrade/femto
	name = "Structural Repairs Combo Upgrade"
	desc = "The ultimate in wound treatment operations, treating both bruises and burns simultaneous and faster than their individual counterparts."
	surgery = /datum/surgery_operation/basic/tend_wounds/combo/synth/upgraded/master
	id = "synthetic_surgery_heal_combo_upgrade_femto"

/**
 * Subsystem Upgrades - there's none that involve bleeding or anything that wouldn't make sense for a synth to have
 */

// Techweb
/datum/techweb_node/robotic_surgery_exp
	id = TECHWEB_NODE_ROBOTIC_SURGERY_EXPERIMENTAL
	display_name = "Experimental Synthetic Surgery"
	description = "When robotics gets a little greedy."
	prereq_ids = list(TECHWEB_NODE_ROBOTIC_SURGERY)
	design_ids = list(
		"surgery_subsystem_upgrade_cortex_folding",
		"surgery_subsystem_upgrade_cortex_imprint",
		"surgery_subsystem_upgrade_ligament_reinforcement",
		"surgery_subsystem_upgrade_muscled_veins",
		"surgery_subsystem_upgrade_nerve_ground",
		"surgery_subsystem_upgrade_nerve_splice",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/scanning/people/android = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

// nerve splicing - Reinforced Servos
/datum/design/surgery/nerve_splicing/synth
	desc = "A surgical procedure which upgrades a synthetic patient's movement servos, allowing it to better resist stuns."
	id = "surgery_subsystem_upgrade_nerve_splice"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/nerve_splicing
	research_icon_state = "surgery_chest"

// nerve grounding - Reinforced Capacitors
/datum/design/surgery/nerve_grounding/synth
	desc = "A surgical procedure which installs an additional capacitor bank designed to abdorb electrical shocks."
	id = "surgery_subsystem_upgrade_nerve_ground"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/nerve_grounding
	research_icon_state = "surgery_chest"

// Muscled Veins - Hydraulics Redundancy Subroutine
/datum/design/surgery/muscled_veins/synth
	desc = "Add redundancies to a robotic patient's hydraulic system, allowing it to pump fluids without an engine or pump."
	id = "surgery_subsystem_upgrade_muscled_veins"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/muscled_veins
	research_icon_state = "surgery_chest"

// ligament reinforcement - Anchor Point Reinforcement
/datum/design/surgery/ligament_reinforcement/synth
	desc = "A surgical procedure which adds reinforcement a robotic patient's limb joints to prevent dismemberment, \
		at the cost of making nerve connections easier to interrupt."
	id = "surgery_subsystem_upgrade_ligament_reinforcement"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/ligament_reinforcement
	research_icon_state = "surgery_chest"

// cortex imprinting - Anti-Cascade 2.0
/datum/design/surgery/cortex_imprint/synth
	desc = "A surgical procedure which updates a robotic patient's underlying operating system to a \"newer version\", improving overall performance and resilience. \
		Shame about all the adware."
	id = "surgery_subsystem_upgrade_cortex_imprint"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint
	research_icon_state = "surgery_chest"

// cortex folding - Neuropathing Reinforcement
/datum/design/surgery/cortex_folding/synth
	desc = "A surgical procedure which reprograms a robotic patient's neural network in a downright eldritch programming language, giving space to non-standard neural patterns. \
		Definitely isn't malware."
	id = "surgery_subsystem_upgrade_cortex_folding"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/cortex_folding
	research_icon_state = "surgery_chest"
