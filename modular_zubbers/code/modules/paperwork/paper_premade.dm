/obj/item/paper/fluff/merge_my_fucking_pr
	default_raw_text = "UH OH"

/obj/item/paper/fluff/merge_my_fucking_pr/Initialize(mapload)

	//I love madlibs.
	//The fallbacks should never roll but you never know.
	var/pr_number = 40000 + (text2num(copytext("\ref[src]",2),16) % 100000) //While scientific notation is funny, it wasn't precise enough
	var/thing_to_remove = LOWER_TEXT(pick_list_replacements(ION_FILE, "ionobjects")) || "Kebab" //2006 called, they want their meme back
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
	var/traitor = replacetextEx(pick_list_replacements(HALLUCINATION_FILE, "accusations") ,"\\%TARGETNAME","a griefer") || "a griefer"
	var/location = replacetextEx(pick_list_replacements(HALLUCINATION_FILE, "location") ,"\\%TARGETNAME","dorms") || "dorms"
	var/branch = replacetextEx("[traitor]-[thing_to_remove]-removal"," ","-")
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
	[pick("The Research Directior needs","Security needs","We need","Central Command needs","Nanotrasen needs")] to remove [thing_to_remove] from
	[pick("the Station","the Crew",job,location)]. [pick("You might be thinking","You're probablly wondering","You might be saying","One might think","Some might say")]
	"[conversation]", [pick("so let me explain","and you'd normally be right","but let me explain","so let me have a moment of your time","give me a second to explain")].
	<br><br>
	[pick("One time","Previously","Last shift","A few moments ago")] that damn griefer george melons was [traitor] [pick("as","while they were")] [job] and [pick("he","they")]
	[pick("killed","assaulted","ass slapped","smacked","bwoinked")] [pick("me","my person","my well being","my ass")] [pick("in","near","around")] [location]
	[pick("with","using","while I didn't have any")] [thing_to_remove]. This [pick("should not have happened","was fucking stupid","made me cry","wasted my time","annoyed me")] so I am
	[pick("petitioning","begging","asking","demanding")] for it to be removed.
	</p>
	<br>
	<h1>Changelog</h1>
	<hr>
	CL [author]<br>
	[pick("del","remove","balance","fix","bugfix")]: Removes [thing_to_remove]<br>
	/CL
	"}

	name = "[initial(name)] - pull request #[pr_number], [title]"

	return ..()
