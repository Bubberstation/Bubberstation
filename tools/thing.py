import dmi as dmi

dmi_thing = dmi.Dmi(32, 32)

#genital = "breasts"
genital = "penis"
#genital = "testicles"
#genital = "vagina"

image = dmi_thing.from_file(f"ztits/{genital}_splurt.dmi")

'''

image = dmi_thing.from_file(f"ztits/{genital}_splurt.dmi")

#	for state in skee_image.states:
#		old_name: str = state.name
#		name_parts = old_name.split('_')
#
#		print(" ".join(name_parts))
#		types_skee[name_parts[2]] = True

i = 0

erroneus_states = []
for state in image.states:
	old_name: str = state.name
	name_parts = old_name.split('_')
	print(' '.join(name_parts))
	if(name_parts[-2] != '0'):
		erroneus_states.append(state)
		i += 1
		continue

	if(len(name_parts[2]) == 1):
		name_parts[2] = str(ord(name_parts[2]) - ord('a') + 1)

	name_parts.pop(-2)
	name_parts.insert(0, "m")
	image.states[i].name = "_".join(name_parts)
	i += 1

for state in erroneus_states:
	image.states.remove(state)

#print(" ".join(types_skee.keys() - types_splurt.keys()))
#print(" ".join(types_splurt))

#skee_image.state()
'''

#	for state in skee_image.states:
#		old_name: str = state.name
#		name_parts = old_name.split('_')
#
#		print(" ".join(name_parts))
#		types_skee[name_parts[2]] = True

i = 0

for state in image.states:
	old_name: str = state.name
	name_parts = old_name.split('_')

	if(name_parts[3] == "s"):
		name_parts[3], name_parts[4] = name_parts[4], name_parts[3]

	name_parts.insert(0, "m")
	name_parts.append("primary")

	print(' '.join(name_parts))
	image.states[i].name = "_".join(name_parts)
	i += 1

#print(" ".join(types_skee.keys() - types_splurt.keys()))
#print(" ".join(types_splurt))

#skee_image.state()
'''
i = 0
erroneus_states = []

for state in image.states:
	old_name: str = state.name
	name_parts = old_name.split('_')

	if(name_parts[-1] == 'FRONT'):
		name_parts[-1] = 'ADJ'

	if(name_parts[-2] != '0'):
		erroneus_states.append(state)
		i += 1
		continue

	if(name_parts[1] == "single"):
		name_parts[1] = "pair"

	name_parts.pop(-2)

	name_parts.insert(0, "m")
	print(' '.join(name_parts))
	image.states[i].name = "_".join(name_parts)
	i += 1

for state in erroneus_states:
	image.states.remove(state)

#print(" ".join(types_skee.keys() - types_splurt.keys()))
#print(" ".join(types_splurt))

#skee_image.state()
'''


image.to_file(f"ztits/{genital}_new.dmi")
