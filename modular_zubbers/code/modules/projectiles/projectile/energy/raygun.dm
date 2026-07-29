/obj/projectile/energy/syndie_raygun
	name = "raygun beam"
	desc = "fucks you up"
	damage = 0.5
	demolition_mod = 0
	damage_type = TOX
	armour_penetration = 200 // we don't want this being blocked
	projectile_phasing =  PASSTABLE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS //evil-ass beams debilitate through walls and also everything else
	range = 10
	speed = 1
	reflectable = FALSE

	hitsound = 'modular_zubbers/sound/weapons/impact_silent.ogg'
	hitsound_wall = 'modular_zubbers/sound/weapons/impact_silent.ogg'
	impact_effect_type = null
	log_override = TRUE

	icon = 'modular_zubbers/icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "death_ray"
	color = rgb(0,0,0)
	alpha = 20 // if you're attentive, you can spot where it's coming from

	//small debilitations, since this is somewhat rapid-fire and meant to hit repeatedly
	eyeblur = 0.5 SECONDS
	stutter = 0.25 SECONDS
	slur = 0.25 SECONDS

/obj/projectile/energy/syndie_raygun/heart
	name = "heartstopper raygun beam"
	color = rgb(255,50,50)
/obj/projectile/energy/syndie_raygun/heart/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_HEART, 1.8)

/obj/projectile/energy/syndie_raygun/liver
	name = "liverworse raygun beam"
	color = rgb(50,255,50)
/obj/projectile/energy/syndie_raygun/liver/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_LIVER, 1.8)

/obj/projectile/energy/syndie_raygun/lungs
	name = "concentrated smoke raygun beam"
	color = rgb(180,180,255)
/obj/projectile/energy/syndie_raygun/lungs/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_LUNGS, 1.8)

/obj/projectile/energy/syndie_raygun/stomach
	name = "gutbuster raygun beam"
	color = rgb(130,75,35)
/obj/projectile/energy/syndie_raygun/stomach/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_STOMACH, 1.8)

/obj/projectile/energy/syndie_raygun/brain
	name = "brain drain raygun beam"
	color = rgb(187,30,73)
/obj/projectile/energy/syndie_raygun/brain/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2)

/obj/projectile/energy/syndie_raygun/sensory
	name = "sensory deprivation raygun beam"
	color = rgb(211,145,255)
/obj/projectile/energy/syndie_raygun/sensory/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_EYES, 0.75)
	target.adjust_organ_loss(ORGAN_SLOT_EARS, 1.50)

/obj/projectile/energy/syndie_raygun/appendix
	name = "appendix exploder raygun beam"
	color = rgb(133,222,172)
/obj/projectile/energy/syndie_raygun/appendix/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_APPENDIX, 2)

/obj/projectile/energy/syndie_raygun/random //deals 50% more organ damage, but targets a random organ
	name = "evil-ass raygun beam"
/obj/projectile/energy/syndie_raygun/random/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	var/organ_selected = rand(1,7)
	if(organ_selected == 1)
		target.adjust_organ_loss(ORGAN_SLOT_HEART, 2.4)
	if(organ_selected == 2)
		target.adjust_organ_loss(ORGAN_SLOT_LIVER, 2.4)
	if(organ_selected == 3)
		target.adjust_organ_loss(ORGAN_SLOT_LUNGS, 2.4)
	if(organ_selected == 4)
		target.adjust_organ_loss(ORGAN_SLOT_STOMACH, 2.4)
	if(organ_selected == 5)
		target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 3)
	if(organ_selected == 6)
		target.adjust_organ_loss(ORGAN_SLOT_EYES, 1.5)
		target.adjust_organ_loss(ORGAN_SLOT_EARS, 2.5)
	if(organ_selected == 7)
		target.adjust_organ_loss(ORGAN_SLOT_APPENDIX, 3)

/obj/projectile/energy/syndie_raygun/random/Initialize(mapload)
	. = ..()
	color = rgb(rand(0, 255), rand(0, 255), rand(0, 255))
