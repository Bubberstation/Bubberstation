GLOBAL_LIST_INIT(redacted_words,list(
	"REDACTED" = 50,
	"CENSORED" = 5,
	"DATA EXPUNGED" = 2,
	"EXPLETIVE" = 1,
	"HONKED" = 1,
	"INFORMATION ABOVE YOUR SECURITY CLEARANCE" = 1,
	"NOTHING TO SEE HERE" = 1,
	"MOVE ALONG CITIZEN" = 1
))


/proc/random_redact(text,redact_word_chance=10) //SCP wiki be like
	if(!text || redact_word_chance <= 0) //wat
		return text
	. = ""
	var/list/words = splittext(text," ")

	var/regex/html_regex = regex(@'[<\/>]+',"i") //Regex prevents us from replacing formatting. I love computers!
	var/safety = FALSE //Prevents censoring two words in a row
	for(var/word in words)
		if(!safety && length(word) >= 4 && prob(redact_word_chance) && !html_regex.Find(word))
			var/chosen_meme_word = pick_weight(GLOB.redacted_words)
			. = "[.]\[[chosen_meme_word]\] "
			safety = TRUE
		else
			. = "[.][word] "
			safety = FALSE

	return trim(.)