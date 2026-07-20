/obj/projectile/energy/syndie_raygun
	name = "raygun beam"
	desc = "fucks you up"
	damage = 1.0
	demolition_mod = 0
	damage_type = TOX
	armour_penetration = 200 // we don't want this being blocked
	projectile_phasing =  PASSTABLE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS //evil-ass beams debilitate through walls
	range = 10
	speed = 2

	log_override = TRUE
	suppressed =  SUPPRESSED_VERY

	//small debilitations, since this is somewhat rapid-fire and meant to hit repeatedly
	eyeblur = 0.5 SECONDS
	stutter = 0.25 SECONDS
	slur = 0.25 SECONDS

/obj/projectile/energy/syndie_raygun/heart
	name = "heartstopper raygun beam"
/obj/projectile/energy/syndie_raygun/heart/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_HEART, 1.8)

/obj/projectile/energy/syndie_raygun/liver
	name = "liverworse raygun beam"
/obj/projectile/energy/syndie_raygun/liver/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_LIVER, 1.8)

/obj/projectile/energy/syndie_raygun/lungs
	name = "concentrated smoke raygun beam"
/obj/projectile/energy/syndie_raygun/lungs/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_LUNGS, 1.8)

/obj/projectile/energy/syndie_raygun/stomach
	name = "gutbuster raygun beam"
/obj/projectile/energy/syndie_raygun/stomach/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	need_mob_update = target.adjust_organ_loss(ORGAN_SLOT_STOMACH, 1.8)

/obj/projectile/energy/syndie_raygun/brain
	name = "brain drain raygun beam"
/obj/projectile/energy/syndie_raygun/brain/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	need_mob_update = target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2)

/obj/projectile/energy/syndie_raygun/sensory
	name = "sensory deprivation raygun beam"
/obj/projectile/energy/syndie_raygun/sensory/on_hit(mob/living/carbon/target, blocked = 0, pierce_hit)
	. = ..()
	target.adjust_organ_loss(ORGAN_SLOT_EYES, 0.80)
	target.adjust_organ_loss(ORGAN_SLOT_EARS, 0.40)

/obj/projectile/energy/syndie_raygun/appendix
	name = "appendix exploder raygun beam"
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
		target.adjust_organ_loss(ORGAN_SLOT_EYES, 1.2)
		target.adjust_organ_loss(ORGAN_SLOT_EARS, 0.6)
	if(organ_selected == 7)
		target.adjust_organ_loss(ORGAN_SLOT_APPENDIX, 3)
