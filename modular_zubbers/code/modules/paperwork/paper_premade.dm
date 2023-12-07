//The maintainer guidelines
/obj/item/paper/fluff/merging_guidelines
	default_raw_text = "UH OH"

/obj/item/paper/fluff/merging_guidelines/Initialize(mapload)

	default_raw_text = {"
	<h1>TOP SECRET MERGING GUIDELINES<h1>
	<h2>For intern maintainer eyes only.</h2>
	<hr>
	<p>Our Station Maintainers are all on vacation right now, so right now there is a Pull Request backlog on our galactic government-mandated open-source suggestion form. Contrary to popular belief, reviewing and merging pull requests into the database requires strict guidelines to be followed, which are listed inside this document.</p>
	<br>
	<p>To merge a pull request, stamp the paper with the "merge" stamp found enclosed in the briefcase, and send it to Central Command via the cargo shuttle system.</p>
	<p>To close a pull request, stamp the paper with the "close" stamp also found enclosed in the briefcase, and send it to Central Command via the carg oshuttle system.</p>
	<p><b>We do not accept faxes.</b></p>
	<br>
	<p>Under <b>no circumstances</b> should you merge removal pull requests of the following things:</p>
	<p><i>[SSeconomy.contributor_guidelines_blacklisted_words_formatted]</i></p>
	<p>Improperly stamped pull requests with more than one stamp, or no valid stamps at all, are not considered valid and should be shredded. Maintainers do not make mistakes, and they certainly don't back out of them.</p>
	<p>Photocopies of pull requests are not accepted.</p>
	<br>
	<p>Merging any pull request will grant the station 1000 credits in funds.</p>
	<p>Merging any pull request that violates these guidelines will result in penalties not exceeding 5000 credits per violatation.</p>
	<p>Note that sending closed pull requests, even if they're bad and violate the guidelines, won't get you anything (except remorse and childish hatred).</p>
	"}

	name = "[initial(name)] - contributor guidelines"
	return ..()

//The randomly generated pull request.
/obj/item/paper/fluff/merge_my_fucking_pr
	default_raw_text = "UH OH"
	var/thing_to_remove = "coders"
	var/last_stamp_icon_state

/obj/item/paper/fluff/merge_my_fucking_pr/add_stamp(stamp_class, stamp_x, stamp_y, rotation, stamp_icon_state)
	. = ..()
	last_stamp_icon_state = stamp_icon_state

/obj/item/paper/fluff/merge_my_fucking_pr/Initialize(mapload)

	//I love madlibs.
	//The fallbacks should never roll but you never know.
	var/pr_number = 40000 + (text2num(copytext("\ref[src]",4,-1),16) % 100000) //While scientific notation is funny, it wasn't precise enough
	thing_to_remove = lowertext(pick_list_replacements(ION_FILE, "ionobjects")) || "kebab" //2006 called, they want their meme back
	var/obj/machinery/nuclearbomb/selfdestruct/self_destruct = locate() in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/nuclearbomb/selfdestruct) //Wait, why the fuck are we trying to get the nuke??? Coder backdoor???
	if(self_destruct)
		if(self_destruct.r_code == NUKE_CODE_UNSET)
			self_destruct.r_code = random_nukecode()
			message_admins("Through salt PRs, the self-destruct code was set to \"[self_destruct.r_code]\".")
		if(self_destruct.r_code == pr_number)
			thing_to_remove = "the station's nuclear self-destruct device" //Just made every senior admin shit themselves with this line. 1 in 140,000 chance, by the way.

	var/title = "Removes [capitalize(thing_to_remove)]"
	var/author = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]" || "Joe Momma"
	var/author_dash = replacetextEx(author," ","-")
	var/conversation = pick_list_replacements(HALLUCINATION_FILE, "conversation") || "Fuck off?"
	var/redpill = pick_list_replacements(REDPILL_FILE, "redpill_questions") || "Why not?"
	var/job = replacetextEx(pick_list_replacements(HALLUCINATION_FILE, "people") ,"\\%TARGETNAME","Security") || "Security"
	var/location = replacetextEx(pick_list_replacements(HALLUCINATION_FILE, "location") ,"\\%TARGETNAME","dorms") || "dorms"
	var/branch = replacetextEx("[thing_to_remove]-removal"," ","-")
	var/dirty_commits = rand(4,75)

	default_raw_text = {"
	<h1>[title] #[pr_number]</h1>
	[author] wants to merge [dirty_commits] commits into \[Space-Station-13:master\] from \[[author_dash]:[branch]\]
	<br>
	<br>
	<br>
	<br>
	<br>
	<hr>
	<h2>About The Pull Request</h2>
	<hr>
	<p>Removes [thing_to_remove].</p>
	<br>
	<h2>Why It's Good For The Station</h2>
	<hr>
	<p>[redpill]</p>
	<p>
	[pick("The Research Directior needs","Security needs","We need","Central Command needs","Nanotrasen needs")] to remove [thing_to_remove] from [pick("the Station","the Crew",job,location)]. [pick("You might be thinking","You're probablly wondering","You might be saying","One might think","Some might say")] "[conversation]", [pick("so let me explain","and you'd normally be right","but let me explain","so let me have a moment of your time","give me a second to explain")].
	<br><br>
	[pick("One time","Previously","Last shift","A few moments ago")] that damn griefer george melons was [job] and [pick("he","they")] [pick("killed","assaulted","ass slapped","smacked","bwoinked")] [pick("me","my person","my well being","my ass")] [pick("in","near","around")] [location] [pick("with","using","while I didn't have any")] [thing_to_remove]. This [pick("should not have happened","was fucking stupid","made me cry","wasted my time","annoyed me")] so I am [pick("petitioning","begging","asking","demanding")] for it to be removed.
	</p>
	<br>
	<h1>Changelog</h1>
	<hr>
	CL [author]<br>
	[pick("del","remove","balance","fix","bugfix")]: Removes [thing_to_remove]<br>
	/CL
	"}

	name = "[initial(name)] - pull request #[pr_number]"

	return ..()
