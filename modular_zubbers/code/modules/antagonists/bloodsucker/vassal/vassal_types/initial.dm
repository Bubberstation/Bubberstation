/datum/antagonist/ghoul/roundstart
	name = "\improper roundstart Ghoul"

/datum/antagonist/ghoul/roundstart/on_gain()
	. = ..()
	if(!master)
		message_admins("WARNING: [owner.current] has a roundstart Ghoul antag datum but no master assigned!")
		CRASH("[owner.current] Roundstart Ghoul has no master assigned!")
	var/list/powers = master.all_bloodsucker_powers
	var/list/valid_powers = list()
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & GHOUL_CAN_BUY)
			valid_powers += power
	if(!length(valid_powers))
		message_admins("WARNING: [owner.current] 's master [master.owner.current] has no valid powers to give to their roundstart Ghoul!")
		CRASH("[owner.current] Roundstart Ghoul's master [master.owner.current] has no valid powers to give!")
	BuyPower(pick(valid_powers))
