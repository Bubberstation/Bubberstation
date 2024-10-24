## SPLURT Station (Bubberstation Downstream)

[![CI Suite](https://github.com/SPLURT-Station/S.P.L.U.R.T-tg/actions/workflows/ci_suite.yml/badge.svg)](https://github.com/SPLURT-Station/S.P.L.U.R.T-tg/actions/workflows/ci_suite.yml)

[![resentment](.github/images/badges/built-with-resentment.svg)](.github/images/comics/131-bug-free.png) [![technical debt](.github/images/badges/contains-technical-debt.svg)](.github/images/comics/106-tech-debt-modified.png) [![forinfinityandbyond](.github/images/badges/made-in-byond.gif)](https://www.reddit.com/r/SS13/comments/5oplxp/what_is_the_main_problem_with_byond_as_an_engine/dclbu1a)
[![resentment](.github/images/badges/built-with-resentment.svg)](.github/images/comics/131-bug-free.png) [![technical debt](.github/images/badges/contains-technical-debt.svg)](.github/images/comics/106-tech-debt-modified.png) [![forinfinityandbyond](.github/images/badges/made-in-byond.gif)](https://www.reddit.com/r/SS13/comments/5oplxp/what_is_the_main_problem_with_byond_as_an_engine/dclbu1a)

| Website                   | Link                                           |
|---------------------------|------------------------------------------------|
| Git / GitHub cheatsheet   | [https://www.notion.so/Git-GitHub-61bc81766b2e4c7d9a346db3078ce833](https://www.notion.so/Git-GitHub-61bc81766b2e4c7d9a346db3078ce833) |
| Guide to Modularization   | [./modular_skyrat/readme.md](./modular_skyrat/readme.md) |
| Website                   | [https://splurtstation.com](https://splurtstation.com) |
| Code                      | [https://github.com/SPLURT-Station/S.P.L.U.R.T-tg](https://github.com/SPLURT-Station/S.P.L.U.R.T-tg) |
| Wiki                      | [https://splurtstation.com](https://splurtstation.com) |
| Codedocs                  | [https://skyrat-ss13.github.io/Skyrat-tg/](https://skyrat-ss13.github.io/Skyrat-tg/) |
| S.P.L.U.R.T Station Discord     | [https://discord.gg/wynHVMzHzC](https://discord.gg/wynHVMzHzC) |

This is S.P.L.U.R.T Station's downstream fork of bubberstation, which is in turn a fork of TG (formerly skyrat).

**Please note that this repository contains sexually explicit content and is not suitable for those under the age of 18.**

Space Station 13 is a paranoia-laden round-based roleplaying game set against the backdrop of a nonsensical, metal death trap masquerading as a space station, with charming spritework designed to represent the sci-fi setting and its dangerous undertones. Have fun, and survive!

## Contribution Rules and Guidelines

**1. Do Not Be A Dick**
- The S.P.L.U.R.T. main repository is run by and contributed by volunteers and hobbiests. Please be considerate with the people who help maintain our codebase. We reserve the right to permanently remove anyone who does not show both our contributors and maintainers common decency.
- S.P.L.U.R.T. does not operate a strict "goodboy" points system or have defined goals, and anyone is welcome to contribute to this project. That being said, the maintainers of this project are free to curate comments as seen fit to uphold a respectful environment.

**2. Modularization Standards Will be Upheld**
- This codebase is a active downstream to Bubberstation with frequent upstream merges.
- Modularization is key to attain code stability, please read our [modularization guide](./modular_zzplurt/readme.md) for more information, or ask any of our maintainers in our discord.

**3. The Licensing is Non-negotiable**
- You are free to take, redistribute, modify, and readapt any code or commit found on this repository.
- All code files are under **GNU AGPL V3**
- All asset files (images and sound) are **CC-BY-SA 3.0** unless otherwise stated
- The license information, including the MIT license and its exceptions, can be found at the bottom of this readme.
- What does this mean to our contributors? **The** [GNU AGPL V3](https://www.gnu.org/licenses/agpl-3.0.html) **licensing on this codebase is non-negotiable** and **irrevocable** the moment you open a PR. We are incapable of privatizing this codebase and you are incapable of restricting your code contributions even if you close the PR. Do not open a contribution if you do not feel comfortable with your code being permanent across the entirety of the community. **All contributions are preserved in commit history**
- What does this mean to our spriters and sound designers? [CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/) **is the only license that this project will accept**
- It is prohibited to use the attribution requirement to [suggest that you endorse or support a particular use](https://creativecommons.org/faq/#do-i-need-to-be-aware-of-anything-else-when-providing-attribution) of your assets.
- You are entitled to credit yourself with comments and you are entitled to waive the attribution requirement choosing not to be identified as the creator if you wish.
- If you do not like how your assets were modified or used, it is required that the other person [remove the attribution information upon request](https://wiki.creativecommons.org/wiki/License_Versions#Licensors_may_request_removal_of_attribution).
- Modifications or adaptions must disclose the source, the author, and [any changes you've made](https://wiki.creativecommons.org/wiki/License_Versions#Modifications_and_adaptations_must_be_indicated).
- Goonstation code is incompatible with this codebase due to its licensing.

*Credit: [Goonstation contribution guidelines](https://hackmd.io/@goonstation/docs/%2F%40goonstation%2Fcontribute#What-if-I-change-my-mind-about-my-contributions-being-published)*

## Modularization and codedocs note

As of our recent split from Skyrat, a lot of codedocs/modularization guides need to be rewritten. Until it is done expect some wait time with larger refactors. You are also free to edit any Skyrat files

## Important note - TEST YOUR PULL REQUESTS

You are responsible for the testing of your content. You should not mark a pull request ready for review until you have actually tested it. If you require a separate client for testing, you can use a guest account by logging out of BYOND and connecting to your test server.

## DOWNLOADING

[Downloading](.github/guides/DOWNLOADING.md)

[Running on the server](.github/guides/RUNNING_A_SERVER.md)

[Maps and Away Missions](.github/guides/MAPS_AND_AWAY_MISSIONS.md)
[Maps and Away Missions](.github/guides/MAPS_AND_AWAY_MISSIONS.md)

## Compilation

Find `BUILD.bat` here in the root folder of tgstation, and double click it to initiate the build. It consists of multiple steps and might take around 1-5 minutes to compile.

**The long way**. Find `bin/build.cmd` in this folder, and double click it to initiate the build. It consists of multiple steps and might take around 1-5 minutes to compile. If it closes, it means it has finished its job. You can then [setup the server](.github/guides/RUNNING_A_SERVER.md) normally by opening `tgstation.dmb` in DreamDaemon.

**Building tgstation in DreamMaker directly is deprecated and might produce errors**, such as `'tgui.bundle.js': cannot find file`.

**[How to compile in VSCode and other build options](tools/build/README.md).**

## TG Guide Contributors
[Guides for Contributors](.github/CONTRIBUTING.md)

## LICENSE

All code after [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.html).

All code before [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
(Including tools unless their readme specifies otherwise.)

See LICENSE and GPLv3.txt for more details.

The TGS DMAPI is licensed as a subproject under the MIT license.
The TGS DMAPI is licensed as a subproject under the MIT license.

See the footer of [code/__DEFINES/tgs.dm](./code/__DEFINES/tgs.dm) and [code/modules/tgs/LICENSE](./code/modules/tgs/LICENSE) for the MIT license.

All assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](https://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.
