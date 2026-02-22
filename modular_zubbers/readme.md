# The modularization handbook - Bubber style, v0.1

## Failure to follow this guide will result in you being asked to change your PR.

## Introduction

Developing and maintaining a separate codebase is a large complex project with lots of risk.

To deal with this, Bubberstation has chosen a solution of modularization, wherein the codebase is based on an upstream (/tg/station) where we pull core features and code from, and gain the benefit of mirroring any changes they perform on their codebase at parity. From there, we add our own content in a modular fashion which we are responsible for.

This allows us to focus more on content and a customized experience, while also reducing a degree of overhead in maintenance effort.

It is important to note that Git as a tool for a version control system is very useful, but does come with the caveat that we need to carefully resolve code conflicts that come from our upstream source.

This guide is intended to provide examples, guidance, and ultimately standards on how we manage our implementation of modularization.

Considering that maintainability is one of the key reasons behind our rebase to another codebase, **this standard will be strictly enforced**.

A well organized, documented and atomized code is the standard we want to set in order to reduce development time, debugging and general pain points.
It is important that contributors adhere to this standard, to the benefit of all.

This document should be considered a living breathing document which can be changed and updated at any time. Considering reviewing it regularly, or even contributing!

## Important note - TEST YOUR PULL REQUESTS

You are responsible for the testing of your content. You should not mark a pull request ready for review until you have actually tested it. You should ensure that you have evidence of testing your PR before submitting it.

For example: If you are adding a new hairstyle, have a short video of a character sporting your hairstyle in-game, showing off all angles of the hairstyle. Or a screenshot of all angles of the hairstyle taken from in-game. This shows that your PR runs, and that the hairstyle works and is selectable in-game to the people reviewing your PR. It also shows off the hairstyle to people wanting to see it.

If you require a separate client for testing, you can use a guest account by logging out of BYOND and connecting to your test server. Test merges are not for bug finding, they are for stress tests where local testing simply doesn't allow for this.

### The nature of merge conflicts

A merge conflict happens when your upstream pull commit is competing with your master or local branch commit.

For example, let's have an original

```byond
var/something = 1
```

in the core code, that we decide to change from 1 to 2 on our end,

```diff
- var/something = 1
+ var/something = 2 // BUBBER EDIT
```

but then our upstream introduces a change in their codebase, changing it from 1 to 4

```diff
- var/something = 1
+ var/something = 4
```

As easy of an example as it is, it results in a relatively simple conflict, in the form of

```byond
var/something = 4 // BUBBER EDIT
```

where we pick the preferable option manually.

### The solution

That is something that cannot and likely shouldn't be resolved automatically, because it might introduce errors and bugs that will be very hard to track down, not to even bring up more complex examples of conflicts, such as ones that involve changes that add, remove and move lines of code all over the place.

tl;dr it tries its best but ultimately is just a dumb program, therefore, we must ourselves do work to ensure that it can do most of the work, while minimizing the effort spent on manual involvement, in the cases where the conflicts will be inevitable.

Our answer to this is modularization of the code.

**Modularization** means, that most of the changes and additions we do, will be kept in a separate **`modular_zubbers/`** folder, as independent from the core code as possible, and those which absolutely cannot be modularized, will need to be properly marked by comments, specifying where the changes start, where they end, and which feature they are a part of, but more on that in the next section.

## The modularization protocol

Always start by thinking of the theme/purpose of your work. It's oftentimes a good idea to see if there isn't an already existing one, that you should append to.

**If it's a tgcode-specific tweak or bugfix, first course of action should be an attempt to discuss and PR it upstream, instead of needlessly modularizing it here.**

The best practice for modularization involves making a **`modular_zubbers/`** version of whatever file you may be working on and copying that path exactly for ease of finding it. For example, if your file is **`code/game/objects/items/crab17.dm`** then you would make your new file in **`modular_zubbers/code/game/objects/items/crab17.dm`**. Sometimes the folders you need may not exist already, it is perfectly fine to make new folders in order to ensure your modular file goes in the same file path as it does on /tg/ just with **`modular_zubbers/`** as the first folder.

New files go in **`modular_zubbers/`** as well, go with your heart as to which file to put them in if there are no exact file matches on /tg/, a personal suggestion would be to look at where _similar_ files go.

**All files in `modular_skyrat/` are free to be edited as you please without need for modularization, however, file creations are restricted, as we aim to remove that folder eventually.**

### Maps

When you are adding a new item to the map you MUST follow this procedure:
Start by deciding how big of a change it is going to be, if it is a small one item change, you should use the simple area automapper. If it is an entire room, you should use the template automapper.

DO NOT CHANGE TG MAPS, THEY ARE HELD TO THE SAME STANDARD AS ICONS. USE THE ABOVE TO MAKE MAP EDITS.

The automapper uses prebaked templates to override sections of a map using coordinates to plot the starting location. See entries in automapper_config.toml for examples.

The simple area automapper uses datum entries to place down a single item in an area of a map that makes vauge sense.

### Assets: images, sounds, icons and binaries

Git doesn't handle conflicts of binary files well at all, therefore changes to core binary files are absolutely forbidden, unless you have a really _really_ **_really_** good reason to do otherwise.

All assets added by us should be placed into the same modular folder as your code. This means everything is kept inside your module folder, sounds, icons and code files.

- **_Example:_** You're adding a new lavaland mob.

  First of all you create your modular folder. E.g. `modular_zubbers/code/modules/mob/living/basic/lavaland`

  And then you'd want to create new files and folders for each component. E.g. `modular_zubbers/sound/items/weapons` for sound files and `modular_zubbers/icons/mob/simple/lavaland` for any icon files.

  After doing this, you'll want to set your references within the code.

  ```byond
    /mob/living/basic/mining/new_mob
      icon = 'modular_zubbers/icons/mob/simple/lavaland/lavaland_monsters.dmi'
      icon_state = "dead_1"
      sound = 'modular_zubbers/sound/items/weapons/bite.ogg'
  ```

  This ensures your code is fully modular and will make it easier for future edits.

- Other assets, binaries and tools, should usually be handled likewise, depending on the case-by-case context. When in doubt, ask a maintainer or other contributors for tips and suggestions.

- Any additional clothing icon files you add MUST go into the existing files in either `modular_zubbers/icons/mob/clothing` for on_mob sprites or `modular_zubbers/icons/obj/clothing` for in-hand sprites.

## Modular Overrides (Important!!)

Note, that it is possible to append code in front, or behind a core proc, in a modular fashion, without editing the original proc, through referring the parent proc, using `. = ..()` or `..()`. And likewise, it is possible to add a new var to an existing datum or obj, without editing the core files.

**Note about proc overrides: Just because you can, doesn't mean you should!!**

In general they are a good idea and encouraged whenever it is possible to do so. However this is not a hard rule, and sometimes Bubber edits are preferable. Just try to use your common sense about it.

For example: please do not copy paste an entire TG proc into a modular override, make one small change, and then bill it as 'fully modular'. These procs are an absolute nightmare to maintain because once something changes upstream you have to update the overridden proc.

Sometimes you aren't even aware the override exists if it compiles fine and doesn't cause any bugs. This often causes features that were added upstream to be missing here. So yeah. Avoid that. It's okay if something isn't fully modular. Sometimes it's the better choice.

The best candidates for modular proc overrides are ones where you can just tack something on after calling the parent, or weave a parent call cleverly in the middle somewhere to achieve your desired effect.

Performance should also be considered when you are overriding a hot proc (like Life() for example), as each additional call adds overhead. Bubber edits are much more performant in those cases. For most procs this won't be something you have to think about, though.

To keep it simple, let's assume you wanted to make guns spark when shot, for simulating muzzle flash or whatever other reasons, and you want potentially to use it with all kinds of guns.

You could start, in a modular file, by adding a var.

```byond
/obj/item/gun
    var/muzzle_flash = TRUE
```

And it will work just fine. Afterwards, let's say you want to check that var and spawn your sparks after firing a shot.
Knowing the original proc being called by shooting is

```byond
/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
```

you can define a child proc for it, that will get inserted into the inheritance chain of the related procs (big words, but in simple cases like this, you don't need to worry)

```byond
/obj/item/gun/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
    . = ..() //. is the default return value, we assign what the parent proc returns to it, as we call it before ours
    if(muzzle_flash)
        spawn_sparks(src) //For simplicity, I assume you've already made a proc for this
```

And that wraps the basics of it up.

### Non-modular changes to the core code - IMPORTANT

Every once in a while, there comes a time, where editing the core files becomes inevitable.

In those cases, we've decided to apply the following convention, with examples:

- **Addition:**

  ```byond
  // BUBBER EDIT - ADDITION - START - SHUTTLE_TOGGLE
  var/adminEmergencyNoRecall = FALSE
  var/lastMode = SHUTTLE_IDLE
  var/lastCallTime = 6000
  // BUBBER EDIT - ADDITION - END
  ```

- **Removal:**

  ```byond
  // BUBBER EDIT - REMOVAL - START - SHUTTLE_TOGGLE
  /*
  for(var/obj/docking_port/stationary/S in stationary)
    if(S.id = id)
      return S
  */
  // BUBBER EDIT - REMOVAL - END
  WARNING("couldn't find dock with id: [id]")
  ```

  And for any removals that are moved to different files:

  ```byond
  // BUBBER EDIT - REMOVAL - START - SHUTTLE_TOGGLE - (Moved to modular_zubbers/shuttle_toggle/randomverbs.dm)
  /*
  /client/proc/admin_call_shuttle()
  set category = "Admin - Events"
  set name = "Call Shuttle"

  if(EMERGENCY_AT_LEAST_DOCKED)
    return

  if(!check_rights(R_ADMIN))
    return

  var/confirm = alert(src, "You sure?", "Confirm", "Yes", "No")
  if(confirm != "Yes")
    return

  SSshuttle.emergency.request()
  SSblackbox.record_feedback("tally", "admin_verb", 1, "Call Shuttle") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
  log_admin("[key_name(usr)] admin-called the emergency shuttle.")
  message_admins(span_adminnotice("[key_name_admin(usr)] admin-called the emergency shuttle."))
  return
  */
  // BUBBER EDIT - REMOVAL - END
  ```

- **Change:**

  ```byond
  // BUBBER EDIT - CHANGE - START - SHUTTLE_TOGGLE
  if(SHUTTLE_STRANDED, SHUTTLE_ESCAPE, SHUTTLE_DISABLED)
  // BUBBER EDIT - CHANGE - END
      return 1
  ```

## Exceptional cases of modular code

From every rule, there's exceptions, due to many circumstances. Don't think about it too much.

### Defines

Due to the way byond loads files, it has become necessary to make a different folder for handling our modular defines.
That folder is **`code/__DEFINES/~~bubber_defines`**, in which you can add them to the existing files, or create those files as necessary.

If you have a define that's used in more than one file, it **must** be declared here.

If you have a define that's used in one file, and won't be used anywhere else, declare it at the top, and `#undef MY_DEFINE` at the bottom of the file. This is to keep context menus clean, and to prevent confusion by those using IDEs with autocomplete.

### Commenting out code - DON'T DO IT

If you are commenting out redundant code in modules, do not comment it out, instead, delete it.

Even if you think someone is going to redo whatever it is you're commenting out, don't, gitblame exists for a reason.

This also applies to files, do not comment out entire files, just delete them instead. This helps us keep down on filebloat and pointless comments.

**This does not apply to non-modular changes.**

## Modular TGUI

TGUI is another exceptional case, since it uses javascript and isn't able to be modular in the same way that DM code is.
ALL of the tgui files are located in `/tgui/packages/tgui/interfaces` and its subdirectories; there is no specific folder for Bubber UIs.

### Modifying upstream files

When modifying upstream TGUI files the same rules apply as modifying upstream DM code, however the grammar for comments may be slightly different.

You can do both `// BUBBER EDIT` and `/* BUBBER EDIT */`, though in some cases you may have to use one over the other.

In general try to keep your edit comments on the same line as the change. Preferably inside the JSX tag. e.g:

```js
<Button
	onClick={() => act('spin', { high_quality: true })}
	icon="rat" // BUBBER EDIT - ADDITION
</Button>
```

```js
<Button
	onClick={() => act('spin', { high_quality: true })}
	// BUBBER EDIT - ADDITION - START
	icon="rat"
	tooltip="spin the rat."
	// BUBBER EDIT - ADDITION - END
</Button>
```

```js
<SomeThing someProp="whatever" /* it also works in self-closing tags */ />
```

If that is not possible, you can wrap your edit in curly brackets e.g.

```js
{
	/* BUBBER EDIT - ADDITION - START */
}
<SomeThing>someProp="whatever"</SomeThing>;
{
	/* BUBBER EDIT - ADDITION - END */
}
```

### Creating new TGUI files

**IMPORTANT! When creating a new TGUI file from scratch, please add the following at the very top of the file (line 1):**

```js
// THIS IS A BUBBER UI FILE
```

This way they are easily identifiable as modular TGUI .tsx/.jsx files. You do not have to do anything further, and there will never be any need for a Bubber edit comment in a modular TGUI file.

## Afterword

It might seem like a lot to take in, but if we remain consistent, it will save us a lot of headache in the long run, once we start having to resolve conflicts manually.
Thanks to a bit more scrupulous documentation, it will be immediately obvious what changes were done and where and by which features, things will be a lot less ambiguous and messy.

Best of luck in your coding. Remember that the community is there for you, if you ever need help.
