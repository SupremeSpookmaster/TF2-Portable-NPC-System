# *Introducing (eventually) the Portable NPC System!*
TODO: Write this.

## *Installation Guide*
1. Install the **[prerequisites]()**.
2. Download the **latest release Installation Build. (LINK PENDING)**
3. Drag-and-drop the contents of the zip file to your server's `tf` folder.
4. **VERY IMPORTANT NOTE:** one major issue with NPCs in TF2 is that melee weapons treat them the same as walls. As a result, while melee weapons *can* damage NPCs, the impact sound is *always* the sound of a melee weapon hitting a metal wall. The Portable NPC System fixes this by implementing its own custom melee hitreg. This hitreg functions identically to TF2's actual melee hitreg, but **forcibly sets every melee weapon's bounds and range (attributes 263 and 264) to 0.0.** If you wish to change a melee weapon's range or bounding box, you will need to use the `"custom hitreg melee range"` and `"custom hitreg melee bounds` custom attributes, which are included with the Portable NPC System. If custom attributes are not an option for whatever reason, you may also use attribute 2000 for melee range and attribute 2001 for melee bounds, though it is preferable to use the custom attributes instead. If you wish to skip this entirely and use TF2's vanilla hitreg, you may disable the custom hitreg in `data/pnpc/settings.cfg`, though I advise against this.

## *Update Guide*
1. Download the **latest release Update Build. (LINK PENDING)**
2. Drag-and-drop the contents of the zip file to your server's `tf` folder.

## *Making NPCs*
TODO: Write a guide in the wiki and link to it here.

## *Prerequisites*
- **[SourceMod V1.12+](https://www.sourcemod.net/downloads.php?branch=dev)**
- **[CBaseNPC](https://github.com/TF2-DMB/CBaseNPC?tab=readme-ov-file)**
- **[TF2 Custom Attributes](https://forums.alliedmods.net/showthread.php?p=2703773)**
- **[TF2Items](https://github.com/asherkin/TF2Items)**
- **[TF2Attributes](https://github.com/FlaminSarge/tf2attributes)**

## *Special thanks to...*
- **[Artvin](https://github.com/artvin01)** and **[Batfoxkid](https://github.com/Batfoxkid)**, the creators of ***[TF2 Zombie Riot](https://github.com/artvin01/TF2-Zombie-Riot)***, which was my inspiration for creating the Portable NPC System. Practically the entire thing was written by reverse-engineering Zombie Riot to pick out the parts I needed, then building on it by adding the CFG system and all the forwards/natives. Without these two, the Portable NPC System would never have come to exist in the first place; they deserve just as much credit as I do for this thing, if not more.
- **[Kenzzer](https://github.com/Kenzzer)**, the creator of **[CBaseNPC](https://github.com/TF2-DMB/CBaseNPC?tab=readme-ov-file)**, without which none of this would even have been possible.

## *Known Bugs/Limitations*
- Huntsman arrows are not able to headshot NPCs. I have absolutely no idea how to fix this, if anybody might know how I would happily accept a pull request.
- TF2 conditions cannot be applied to NPCs. I will not be writing a workaround for this as it would take way too long and ultimately not be very useful, you're better off writing the functionality of the condition you need into your own custom NPC logic.
- A lot of very specific/niche weapon attributes do not work against NPCs. As I continue to work on this plugin, I will gradually make more of these non-functioning attributes compatible with NPCs, but this is not a guarantee.
- NPCs cannot be airblasted. I may or may not add this functionality in the future, no promises.
