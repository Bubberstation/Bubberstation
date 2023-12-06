/obj/item/paper/fluff/merge_my_fucking_pr
	default_raw_text = "UH OH"

/obj/item/paper/fluff/merge_my_fucking_pr/Initialize(mapload)


	//I love madlibs.
	var/thing_to_remove = lowertext(pick_list(ION_FILE, "ionobjects")) || "Kebab" //2006 called, they want their meme back
	var/title = "Removes [capitalize(thing_to_remove)]"
	var/author = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]" || "Joe Momma"
	var/author_dash = replacetextEx(author," ","-")
	var/conversation = pick_list(HALLUCINATION_FILE, "conversation") || "Fuck off?"
	var/redpill = pick_list(REDPILL_FILE, "redpill_questions") || "Why not?"
	var/job = replacetextEx(pick_list(HALLUCINATION_FILE, "people") ,"\\%TARGETNAME","Security") || "Security"
	var/traitor = replacetextEx(pick_list(HALLUCINATION_FILE, "accusations") ,"\\%TARGETNAME","lewd") || "lewd"
	var/location = replacetextEx(pick_list(HALLUCINATION_FILE, "location") ,"\\%TARGETNAME","dorms") || "dorms"
	var/branch = replacetextEx("[traitor]-[thing_to_remove]-removal"," ","-")
	var/pr_number = text2num("\ref[src]",16)
	var/dirty_commits = rand(4,75)

	default_raw_text = {"
	<h1>[title] #[pr_number]</h1>
	&emsp;&emsp;;&emsp; [author] wants to merge [dirty_commits] commits into \[Space-Station-13:master\] from \[[author_dash]:[branch]
	<br>
	<hr>
	<h2>About The Pull Request</h2>
	<hr>
	<p>Removes [thing_to_remove].</p>
	<br>
	<h2>Why It's Good For The Station</h2>
	<hr>
	<p>[redpill]</p>
	<br>
	<p>
	[pick("The Research Directior needs","Security needs","We need","Central Command needs","Nanotrasen needs")] to remove [thing_to_remove] from [pick("the Station","the Crew",job,location)]. You might be thinking "[conversation]", so let me explain.<br>
	[pick("One time","Previously","Last shift","A few moments ago")] that damn griefer george melons was [job] as [traitor] and he [pick("killed","assaulted","ass slapped","smacked","bwoinked")] me [pick("in","near","around")] [location] [pick("with","using","while I didn't have")] [thing_to_remove]. This [pick("should not have happened","was fucking stupid","made me cry","wasted my time","annoyed me")] so I [pick("petitioning","begging","asking","demanding")] for it to be removed.
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