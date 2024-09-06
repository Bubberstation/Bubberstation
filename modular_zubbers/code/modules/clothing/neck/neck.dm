//Override thing from Monkey. Lets us tie bowties.

/obj/item/clothing/neck/tie
	var/tie_type = "tie_greyscale"

/obj/item/clothing/neck/tie/update_icon()
	. = ..()
	// Normal strip & equip delay, along with 2 second self equip since you need to squeeze your head through the hole.
	if(is_tied)
		icon_state = "[tie_type]_tied"
		strip_delay = 4 SECONDS
		equip_delay_other = 4 SECONDS
		equip_delay_self = 2 SECONDS
	else // Extremely quick strip delay, it's practically a ribbon draped around your neck
		icon_state = "[tie_type]_untied"
		strip_delay = 1 SECONDS
		equip_delay_other = 1 SECONDS
		equip_delay_self = 0

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/neck/tie/bunnytie
	name = "bowtie collar"
	desc = "A fancy tie that includes a collar. Looking snazzy!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_tied"
	tie_type = "bowtie_collar"
	greyscale_colors = "#ffffff#39393f"
	greyscale_config = /datum/greyscale_config/bowtie_collar
	greyscale_config_worn = /datum/greyscale_config/bowtie_collar_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = UNDER_SUIT_LAYER

/obj/item/clothing/neck/tie/bunnytie/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/syndicate
	name = "blood-red bowtie collar"
	desc = "A fancy tie that includes a red collar. Looking sinister..."
	icon_state = "bowtie_collar_syndi_tied"
	tie_type = "bowtie_collar_syndi"
	armor_type = /datum/armor/large_scarf_syndie
	tie_timer = 2 SECONDS //Tactical tie
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/syndicate/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/magician
	name = "magician's bowtie collar"
	desc = "A fancy gold tie that includes a collar. Looking magical!"
	icon_state = "bowtie_collar_wiz_tied"
	tie_type = "bowtie_collar_wiz"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	custom_price = null

/obj/item/clothing/neck/tie/bunnytie/magician/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/centcom
	name = "centcom bowtie collar"
	desc = "A fancy gold tie that includes a collar. Looking in charge!"
	icon_state = "bowtie_collar_centcom_tied"
	tie_type = "bowtie_collar_centcom"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/centcom/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/communist
	name = "really red bowtie collar"
	desc = "A simple red tie that includes a collar. Looking egalitarian!"
	icon_state = "bowtie_collar_communist_tied"
	tie_type = "bowtie_collar_communist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/communist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/blue
	name = "blue bowtie collar"
	desc = "A simple blue tie that includes a collar. Looking imperialist!"
	icon_state = "bowtie_collar_blue_tied"
	tie_type = "bowtie_collar_blue"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/blue/tied
	is_tied = TRUE

//CAPTAIN

/obj/item/clothing/neck/tie/bunnytie/captain
	name = "captain's bowtie"
	desc = "A blue tie that includes a collar. Looking commanding!"
	icon_state = "bowtie_collar_captain_tied"
	tie_type = "bowtie_collar_captain"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/captain/tied
	is_tied = TRUE

//CARGO

/obj/item/clothing/neck/tie/bunnytie/cargo
	name = "cargo bowtie"
	desc = "A brown tie that includes a collar. Looking unionized!"
	icon_state = "bowtie_collar_cargo_tied"
	tie_type = "bowtie_collar_cargo"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cargo/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/miner
	name = "shaft miner's bowtie"
	desc = "A purple tie that includes a collar. Looking hardy!"
	icon_state = "bowtie_collar_explorer_tied"
	tie_type = "bowtie_collar_explorer"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/miner/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/mailman
	name = "mailman's bowtie"
	desc = "A red tie that includes a collar. Looking unstoppable!"
	icon_state = "bowtie_collar_mail_tied"
	tie_type = "bowtie_collar_mail"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/mail/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/bitrunner
	name = "bitrunner's bowtie"
	desc = "Bitrunners were told that wearing a novelty shirt with a printed bow tie wasn't enough for formal events."
	icon_state = "bowtie_collar_bitrunner_tied"
	tie_type = "bowtie_collar_bitrunner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/bitrunner/tied
	is_tied = TRUE

//ENGI

/obj/item/clothing/neck/tie/bunnytie/engineer
	name = "engineering bowtie"
	desc = "An orange tie that includes a collar. Looking industrious!"
	icon_state = "bowtie_collar_engi_tied"
	tie_type = "bowtie_collar_engi"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/engineer/tied
	is_tied = TRUE


/obj/item/clothing/neck/tie/bunnytie/atmos_tech
	name = "atmospheric technician's bowtie"
	desc = "A blue tie that includes a collar. Looking inflammable!"
	icon_state = "bowtie_collar_atmos_tied"
	tie_type = "bowtie_collar_atmos"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/atmos_tech/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/ce
	name = "chief engineer's bowtie"
	desc = "A green tie that includes a collar. Looking managerial!"
	icon_state = "bowtie_collar_ce_tied"
	tie_type = "bowtie_collar_ce"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/ce/tied
	is_tied = TRUE

//MEDICAL

/obj/item/clothing/neck/tie/bunnytie/doctor
	name = "medical bowtie"
	desc = "A light blue tie that includes a collar. Looking helpful!"
	icon_state = "bowtie_collar_doctor_tied"
	tie_type = "bowtie_collar_doctor"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/doctor/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/paramedic
	name = "paramedic's bowtie"
	desc = "A white tie that includes a collar. Looking selfless!"
	icon_state = "bowtie_collar_paramedic_tied"
	tie_type = "bowtie_collar_paramedic"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/paramedic/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/chemist
	name = "chemist's bowtie"
	desc = "An orange tie that includes a collar. Looking explosive!"
	icon_state = "bowtie_collar_chem_tied"
	tie_type = "bowtie_collar_chem"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/chemist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/pathologist
	name = "pathologist's bowtie"
	desc = "A green tie that includes a collar. Looking infectious!"
	icon_state = "bowtie_collar_virologist_tied"
	tie_type = "bowtie_collar_virologist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/pathologist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/coroner
	name = "coroner's bowtie"
	desc = "A black tie that includes a collar. Looking dead...Dead good!"
	icon_state = "bowtie_collar_coroner_tied"
	tie_type = "bowtie_collar_coroner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/coroner/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/cmo
	name = "chief medical officer's bowtie"
	desc = "A blue tie that includes a collar. Looking responsible!"
	icon_state = "bowtie_collar_cmo_tied"
	tie_type = "bowtie_collar_cmo"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cmo/tied
	is_tied = TRUE

//SCIENCE

/obj/item/clothing/neck/tie/bunnytie/scientist
	name = "scientist's bowtie"
	desc = "A purple tie that includes a collar. Looking intelligent!"
	icon_state = "bowtie_collar_science_tied"
	tie_type = "bowtie_collar_science"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/scientist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/roboticist
	name = "roboticist's bowtie"
	desc = "A red tie that includes a collar. Looking transhumanist!"
	icon_state = "bowtie_collar_roboticist_tied"
	tie_type = "bowtie_collar_roboticist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/roboticist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/geneticist
	name = "geneticist's bowtie"
	desc = "A blue tie that includes a collar. Looking aberrant!"
	icon_state = "bowtie_collar_genetics_tied"
	tie_type = "bowtie_collar_genetics"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/geneticist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/rd
	name = "research director's bowtie"
	desc = "A purple tie that includes a collar. Looking inventive!"
	icon_state = "bowtie_collar_science_tied"
	tie_type = "bowtie_collar_science"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/scientist/tied
	is_tied = TRUE

//SECURITY

/obj/item/clothing/neck/tie/bunnytie/security
	name = "security bowtie"
	desc = "A red tie that includes a collar. Looking tough!"
	icon_state = "bowtie_collar_sec_tied"
	tie_type = "bowtie_collar_sec"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/security/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/security_assistant
	name = "security assistant's bowtie"
	desc = "A grey tie that includes a collar. Looking \"helpful\"."
	icon_state = "bowtie_collar_sec_assistant_tied"
	tie_type = "bowtie_collar_sec_assistant"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/security_assistant/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/brig_phys
	name = "brig physician's bowtie"
	desc = "A red tie that includes a collar. Looking underappreciated!"
	icon_state = "bowtie_collar_brig_phys_tied"
	tie_type = "bowtie_collar_brig_phys"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/brig_phys/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/detective
	name = "detective's tie collar"
	desc = "A brown tie that includes a collar. Looking inquisitive!"
	icon_state = "tie_collar_det_tied"
	tie_type = "tie_collar_det"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/detective/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/prisoner
	name = "prisoner's bowtie"
	desc = "A black tie that includes a collar. Looking criminal!"
	icon_state = "bowtie_collar_prisoner_tied"
	tie_type = "bowtie_collar_prisoner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/prisoner/tied
	is_tied = TRUE

//SERVICE

/obj/item/clothing/neck/tie/bunnytie/hop
	name = "head of personnel's bowtie"
	desc = "A dull red tie that includes a collar. Looking bogged down."
	icon_state = "bowtie_collar_hop_tied"
	tie_type = "bowtie_collar_hop"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/hop/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/janitor
	name = "janitor's bowtie"
	desc = "A purple tie that includes a collar. Looking tidy!"
	icon_state = "bowtie_collar_janitor_tied"
	tie_type = "bowtie_collar_janitor"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/janitor/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/bartender
	name = "bartender's bowtie"
	desc = "A black tie that includes a collar. Looking fancy!"
	flags_1 = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/neck/tie/bunnytie/bartender/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/cook
	name = "cook's bowtie"
	desc = "A red tie that includes a collar. Looking culinary!"
	icon_state = "bowtie_collar_chef_tied"
	tie_type = "bowtie_collar_chef"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cook/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/botanist
	name = "botanist's bowtie"
	desc = "A blue tie that includes a collar. Looking green-thumbed!"
	icon_state = "bowtie_collar_botany_tied"
	tie_type = "bowtie_collar_botany"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/botanist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/clown
	name = "clown's bowtie"
	desc = "An outrageously large blue bowtie. Looking funny!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "bowtie_clown_tied"
	tie_type = "bowtie_clown"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null
	tie_timer = 8 SECONDS //It's a BIG bowtie

/obj/item/clothing/neck/tie/clown/tied
	is_tied = TRUE

/obj/item/clothing/neck/bunny_pendant
	name = "bunny pendant"
	desc = "A golden pendant depicting a holy rabbit."
	icon_state = "chaplain_pendant"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'

/obj/item/clothing/neck/tie/bunnytie/lawyer_black
	name = "lawyer's black tie collar"
	desc = "A black tie that includes a collar. Looking legal!"
	icon_state = "tie_collar_lawyer_black_tied"
	tie_type = "tie_collar_lawyer_black"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_black/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_blue
	name = "lawyer's blue tie collar"
	desc = "A blue tie that includes a collar. Looking defensive!"
	icon_state = "tie_collar_lawyer_blue_tied"
	tie_type = "tie_collar_lawyer_blue"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_blue/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_red
	name = "lawyer's red tie collar"
	desc = "A red tie that includes a collar. Looking prosecutive!"
	icon_state = "tie_collar_lawyer_red_tied"
	tie_type = "tie_collar_lawyer_red"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_red/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_good
	name = "good lawyer's tie collar"
	desc = "A black tie that includes a collar. Looking technically legal!"
	icon_state = "tie_collar_lawyer_good_tied"
	tie_type = "tie_collar_lawyer_good"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_good/tied
	is_tied = TRUE

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

