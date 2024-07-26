# The Modularization Handbook - S.P.L.U.R.T. Style, v1.0

## Introduction

Welcome to the S.P.L.U.R.T. codebase's modularization handbook! Our goal is to make contributing to our codebase as easy and comfy as possible for coders while upkeeping our code standards. We understand that maintaining a codebase that's a fork of another can be challenging, but with the right practices, we can keep our code clean, organized, and easy to manage. This handbook outlines our modularization protocols and coding standards to help you get started.

If you'd like to know more about coding, contributing and contribution standards, feel free to read this repository's [contribution guides](./.github/guides)!

## Important Note - Test Your Pull Requests

You are responsible for testing your content. Please do not mark a pull request as ready for review until you have thoroughly tested it. If you need a separate client for testing, you can use a guest account by logging out of BYOND and connecting to your test server. Test merges are for stress tests, not for finding bugs that could have been caught with local testing.

## The Nature of Conflicts

Conflicts can arise when changes are made to the same lines of code in different branches. For example, if the original code is:

```byond
var/something = 1
```

And we change it to:

```diff
- var/something = 1
+ var/something = 2 //SPLURT EDIT
```

But upstream changes it to:

```diff
- var/something = 1
+ var/something = 4
```

This results in a conflict that needs to be resolved manually. Our solution is modularization.

## The Modularization Protocol

Modularization is the practice of organizing code into separate, self-contained modules that can be developed, tested, and maintained independently. In the context of our codebase, this means placing as much as possible of the new code, icons, sounds, and other assets into the `modular_zzplurt` folder. This approach helps keep our core codebase clean and reduces the likelihood of conflicts when merging changes. By following a structure that resembles the main repository within the `modular_zzplurt` folder, we ensure that our modular code is easy to navigate and manage. This also allows us to make changes and add new features without directly modifying the core files, thereby maintaining the integrity and stability of the main codebase.

Our modularization protocols are founded on three pillars:

1. **Modularize anything that's reasonable to modularize:** This includes anything that can be modularized without decreasing its quality or the quality of existing code, and won't logically cause more issues by modularizing than not doing it.
2. **Use commenting conventions for non-modular edits:** When editing non-modular code, make sure to adequately use the [commenting conventions](#commenting-conventions) to ensure it is known that it's a non-modular edit.
3. **It's ok to mess up:** These guidelines are intended less as a set of ironclad rules for contributors to strictly follow, but rather coding standards that we all collectively help to attain, for example through maintainers helping any contributors fulfill them in their pull requests.

### Modular Overrides

Modular overrides allow us to extend or modify the behavior of existing code without directly editing the core files. This is done by creating new definitions or modifying existing ones in a way that they can be easily integrated into the core codebase.

There are two main types of modular overrides: Variable Overrides and Proc Overrides.

#### Variable Overrides

Variable overrides allow you to modify existing variables in a modular fashion. This is useful when you need to introduce new properties to existing objects without altering the core code. For example:

```byond
/obj/item/gun
    var/muzzle_flash = TRUE

    ...

/obj/item/gun
    muzzle_flash = FALSE
```

In this example, a new variable muzzle_flash is added to the /obj/item/gun object with a value of `TRUE`. The value of this variable is later changed to `FALSE` through overriding.

#### Proc Overrides

Proc overrides allow you to extend or modify the behavior of existing procedures (procs) without directly editing the core files. This is done by defining a new proc that calls the original proc and then adds the new behavior. For example:

```byond
/obj/item/gun/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
    . = ..() // Call the original proc and set its value to the default return value
    if(muzzle_flash)
        spawn_sparks(src) // Add new behavior
```

In this example, the shoot_live_shot proc is overridden to add a new behavior (spawning sparks) after calling the original proc. This ensures that the new behavior is added without modifying the core code.

#### How and Why Modular Overrides Work

Modular overrides work by leveraging BYOND's file inclusion and proc definition order. When BYOND compiles the code, it processes files and definitions in the order that they're included in [tgstation.dme](./../tgstation.dme). BYOND orders said includes in alphabetical order, with `_` being before all letters, and `~` being after.

Proc overrides run in the order of last-defined to first-defined. This means that the most recently defined proc will be the one that is executed. By placing our overrides in files that are included later in the compilation process, we ensure that they take precedence over earlier definitions.

#### Why modular_zzplurt?

The folder is named `modular_zzplurt` rather than `modular_splurt` to ensure that it comes after all other `modular_` folders in the alphabetical order. This guarantees that our modular overrides are processed last, allowing them to effectively override any previous definitions.

#### When to Use Modular Overrides

Modular overrides should be used whenever possible to keep the core codebase clean and maintainable. However, it's important to use them judiciously and ensure that they do not introduce performance issues or make the code harder to understand and maintain. Specifically:

- **Use modular overrides when they won't cause more issues than not modularizing them:** If a modular override would introduce significant complexity, performance issues, or maintenance challenges, it may be better to make a non-modular edit with proper commenting.
- **Document your overrides:** Clearly documenting any modular overrides in your code helps maintainers and other contributors understand your changes and their purpose.

By following these guidelines, we can ensure that our codebase remains clean, maintainable, and easy to navigate, while still allowing for the flexibility to add new features and make necessary changes.

## Folder Structure

Instead of using different modules for every different bit of the game, we prefer to use a structure that resembles the structure of the repo itself inside our modular folder. This means we have one coding folder for all the code, one icons folder, one sounds folder, etc.

- **Code:** Any .dm files should go in `modular_zzplurt/code/`.
- **Icons:** Any .dmi files should go in `modular_zzplurt/icons/`.
- **Sounds:** Any sound files should go in `modular_zzplurt/sounds/`.

## Commenting Conventions

When making non-modular changes to the core code, please use the following commenting conventions or similar:

- **Addition:**

```byond
  //SPLURT EDIT ADDITION BEGIN - FEATURE_NAME - (Optional Reason/comment)
  var/adminEmergencyNoRecall = FALSE
  var/lastMode = SHUTTLE_IDLE
  var/lastCallTime = 6000
  //SPLURT EDIT ADDITION END
```

- **Removal:**

```byond
  //SPLURT EDIT REMOVAL BEGIN - FEATURE_NAME - (Optional Reason/comment)
  /*
  for(var/obj/docking_port/stationary/S in stationary)
    if(S.id = id)
      return S
  */
  //SPLURT EDIT REMOVAL END
  WARNING("couldn't find dock with id: [id]")
```

- **Change:**

```byond
  //SPLURT EDIT CHANGE BEGIN - FEATURE_NAME - (Optional Reason/comment)
  //if(SHUTTLE_STRANDED, SHUTTLE_ESCAPE) - SPLURT EDIT - ORIGINAL
  if(SHUTTLE_STRANDED, SHUTTLE_ESCAPE, SHUTTLE_DISABLED)
  //SPLURT EDIT CHANGE END
      return 1
```

## Modular Defines

Our modular defines are located at `code/__DEFINES/~~~splurt_defines`. If you have a define that's used in more than one file, it must be declared here. If you have a define that's used in one file and won't be used anywhere else, declare it at the top and `#undef MY_DEFINE` at the bottom of the file.

## Binary Files and Maps

It's preferable to use modular binary files (sounds, icons, assets, etc.) to add content rather than editing non-modular binary files. This should always be your first option when working with binary files. However, if it is absolutely necessary, you may edit non-modular binary files. Remember, if you want to edit maps or binary files, you must install the hooks located in tools/hooks/install.bat.

**For sound files** the only accepted format to use in the codebase is `.ogg`. All files should be as compressed as possible to not bloat our rsc files.

### Maps

When editing maps, especially those that exist in the upstream codebase, the first option should be to use the automapper. The automapper allows you to make modular edits to maps by applying changes through predefined templates and coordinates, ensuring that the core map files remain untouched.

There are two main ways to use the automapper: the simple area automapper for small changes and the template automapper for larger changes.

1. **Simple Area Automapper:**

	- Use this for small changes, such as adding a single item to an area.
	- Define the item and its location in the automapper configuration.
	- This will place the specified item at the given coordinates in the specified area.

2. **Template Automapper:**

	- Use this for larger changes, such as modifying entire rooms or sections of the map.
	- Create a template file that defines the changes you want to make.
	- Add entries to the automapper_config.toml file to specify where and how the template should be applied.
	- This will apply the changes defined in the template file at the given coordinates.

Direct edits to the map files should only be made if the automapper is not sufficient for the intended edits. This ensures that our map changes remain modular and easier to manage.

## Afterword

We hope this handbook makes contributing to S.P.L.U.R.T. a pleasant experience. Remember, these guidelines are here to help maintain the quality and organization of our codebase. If you have any questions or need assistance, don't hesitate to reach out to our maintainers or the community. Happy coding!
