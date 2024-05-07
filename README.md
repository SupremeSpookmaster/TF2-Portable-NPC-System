# *Introducing (eventually) the Portable NPC System!*
TODO: Write this.

## *Installation Guide*
1. Install the **[prerequisites]()**.
2. Download the **latest release Installation Build. (LINK PENDING)**
3. Drag-and-drop the contents of the zip file to your server's `tf` folder.
4. The Portable NPC System is now active on your server!

## *Update Guide*
1. Download the **latest release Update Build. (LINK PENDING)**
2. Drag-and-drop the contents of the zip file to your server's `tf` folder.
3. The Portable NPC System is now updated on your server!

## *IMPORTANT DISCLAIMERS*
1. One major issue with NPCs in TF2 is that melee weapons treat them the same as walls. As a result, while melee weapons *can* damage NPCs, the impact sound is *always* the sound of a melee weapon hitting a metal wall. The Portable NPC System fixes this by implementing its own custom melee hitreg. This hitreg functions identically to TF2's actual melee hitreg, but simulates melee bounds and range on its own, using TF2's default range and bounds modified by the weapon's bounds and range attribuites. If you wish to use TF2's vanilla hitreg, you may disable the custom hitreg in `data/pnpc/settings.cfg`, though I advise against this as there's really no reason to use TF2's default melee hitreg.
2. Another major issue with NPCs in TF2 is that they block explosions. For example: if you fire a rocket at an NPC, that NPC will take damage, but anything behind it will not, even if they are within the blast radius. The Portable NPC System gets around this by simulating all of TF2's explosions manually. These explosions function identically to TF2's explosions, but if, for whatever reason, you want to turn off the simulation in favor of using TF2's vanilla explosions, you may do so in `data/pnpc/settings.cfg`. Again, I advise against this.

## *Making NPCs*
TODO: Write a guide in the wiki and link to it here.

## *Prerequisites*
- **[SourceMod V1.12+](https://www.sourcemod.net/downloads.php?branch=dev)**
- **[CBaseNPC](https://github.com/TF2-DMB/CBaseNPC?tab=readme-ov-file)**
- **[TF2 Custom Attributes](https://forums.alliedmods.net/showthread.php?p=2703773)**
- **[TF2Items](https://github.com/asherkin/TF2Items)**
- **[TF2Attributes](https://github.com/FlaminSarge/tf2attributes)**

## *Special thanks to...*
- **[Artvin](https://github.com/artvin01)** and **[Batfoxkid](https://github.com/Batfoxkid)**, the creators of ***[TF2 Zombie Riot](https://github.com/artvin01/TF2-Zombie-Riot)***, which was my inspiration for creating the Portable NPC System. Practically the entire thing was written by reverse-engineering Zombie Riot to pick out the parts I needed, then building on it by adding the CFG system and all the forwards/natives. Artvin in specific warned me of a number of bizarre bugs with NPCs in TF2, which I likely would not have noticed on my own. Without these two, the Portable NPC System would never have come to exist in the first place; they deserve just as much credit as I do for this thing, if not more.
- **[Kenzzer](https://github.com/Kenzzer)**, the creator of **[CBaseNPC](https://github.com/TF2-DMB/CBaseNPC?tab=readme-ov-file)**, without which none of this would even have been possible.

## *Known Bugs/Limitations*
- Some custom damage sources (example: a custom laser beam that damages enemies) will not work against NPCs, as their developers coded them in such a way where they can only hit clients, *not* entities. This is the fault of poorly-written plugins, not the Portable NPC System, and I cannot fix it. Instead, if your server has such damage sources, either edit their code to be compatible with entities, or contact the developers of those damage sources and ask them to fix it.
- Huntsman arrows are not able to headshot NPCs. I have absolutely no idea how to fix this, if anybody might know how I would happily accept a pull request.
- TF2 conditions cannot be applied to NPCs. I will not be writing a workaround for this as it would take way too long and ultimately not be very useful, you're better off writing the functionality of the condition you need into your own custom NPC logic.
- A lot of very specific/niche weapon attributes do not work against NPCs. As I continue to work on this plugin, I will gradually make more of these non-functioning attributes compatible with NPCs, but this is not a guarantee.
- NPCs cannot be airblasted. I may or may not add this functionality in the future, no promises.
- Jars (jarate, mad milk) do not work against NPCs. They just bounce off, and the contents do not splash on them. This is something I intend to fix in the future.
- Sandman balls harmlessly bounce off of NPCs. This is something I intend to fix in the future.
- NPCs cannot be damaged by bleed effects (boston basher, wrap assassin, etc). This is something I intend to fix in the future.
