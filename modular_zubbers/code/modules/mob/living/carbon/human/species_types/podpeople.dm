/datum/species/pod
	inert_mutation = /datum/mutation/harmonizing_pulses
	sort_bottom = TRUE //BUBBER EDIT ADDITION: We want to sort this to the bottom because it's a ghostrole only species.

/datum/species/pod/get_species_description()
	return list(
	"Aeons ago, the precursor podpeople stood alone among the sea of stars. They resolved to spread the seeds of life \
	that would ultimately survive them. Disease forced the last remnants into scarce few seedvaults, sequestered away. \
	Genetic reconstruction has revived this species from bone and dust, growing new life from replica pods designed to simulate the genesis of Podpeople.",

	"Their complex biology is benign to medical scanners, and they heal in starlight, at the cost of being more susceptible to heat and burns.",
	)

/datum/species/pod/get_species_lore()
	return list(
		"Podpeople (known as Sylvans to their own) are a species of plant person deeply connected to nature. \
		Their hair is generally vibrant, made of vines and brambles, and Podpeople generally take great joy in styling it. \
		Podpeople generally grow at a similar rate and size to humans, though their hair tends to grow facing the most common \
		direction of the sun in the system in which they reside, sometimes growing fruits and other plants when light is plentiful.",

		"Podpeople are often characterized as curious and outgoing, yet sheltered. The scale of the universe can be overwhelming to them. \
		Podpeople that exist outside of the seed vaults tend to excel at intellectual pursuits, like archaeology, research, and hydroponics. \
		They have recently become more prevalent in Sector C7 due to recently discovered evidence of Sylvan development on Indecipheres. \
		Podpeople tend to live for two to three centuries, so the extended contracts offered by Nanotrasen are less daunting.",

		"Podpeople were one of the first species in the life of the universe to spring into existence \
		when planets were more tightly packed together and the universe was warmer. Their home planet is suspected to have been unusually verdant, \
		which the Sylvans seemed to have a symbiotic relationship with. It has been described in detail, but its location remains elusive. \
		True Sylvans encountered by xenoarchaeologists have thus far tended to die of disease months after being exposed to outside life.",

		"At some point in their life cycle, Podpeople were shown to be capable of some form of short-range space travel, spreading their progeny through the stars. \
		Their technological advancements were apparently few, at least compared to contemporary examples, and no Podperson vessels have been uncovered to date. \
		Recovered documentation and oral history suggest that the Podpeople feared diseases that would prey on their apparent lack of genetic diversity.",

		"There are records of podperson vaults across the universe, typically containing one or two operators, \
		though the largest by far has recently been discovered on the surface of Indecipheres, \
		Suggesting a connection between the Podpeople and the living nature of the asteroid. Research is currently ongoing.",
	)
