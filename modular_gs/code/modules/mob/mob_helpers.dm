//GS13 - BURP SLURRING, USED IN SOME CHEMS OR EFFECTS

/proc/burpslur(phrase, strength = 50)
	strength = min(50, strength)
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/newletter = ""
	var/rawchar = ""
	for(var/i = 1, i <= leng, i += length(rawchar))
		rawchar = newletter = phrase[i]
		if(rand(1,100)<=strength * 0.5)
			var/lowerletter = lowertext(newletter)
			if(lowerletter == "o")
				newletter = "+BURRP+"
			else if(lowerletter == "s")
				newletter = "+URP+"
			else if(lowerletter == "a")
				newletter = "+GWUURRP+"
			else if(lowerletter == "u")
				newletter = "+BUUUURRP+"
			else if(lowerletter == "c")
				newletter = "+BURP+"
		if(rand(1,100) <= strength * 0.25)
			if(newletter == " ")
				newletter = "...+GWWUUARRP+..."
			else if(newletter == ".")
				newletter = "+BWUUARRP+."
		switch(rand(1,100) <= strength * 0.5)
			if(1)
				newletter += "+BURRP+"
			if(10)
				newletter += "[newletter]"
			if(20)
				newletter += "[newletter][newletter]"
		. += "[newletter]"
	return sanitize(.)
