# *Introducing (eventually) the Portable NPC System!*
TODO: Write this.

## *Installation Guide*
TODO: Write this.

## *Making NPCs*
TODO: Write a guide in the wiki and link to it here.

## *Prerequisites*
- **[SourceMod V1.12+](https://www.sourcemod.net/downloads.php?branch=dev)**
- **[CBaseNPC](https://github.com/TF2-DMB/CBaseNPC?tab=readme-ov-file)**

## *Special thanks to...*
- **[Artvin](https://github.com/artvin01)** and **[Batfoxkid](https://github.com/Batfoxkid)**, the creators of ***[TF2 Zombie Riot](https://github.com/artvin01/TF2-Zombie-Riot)***, which was my inspiration for creating the Portable NPC System. Practically the entire thing was written by reverse-engineering Zombie Riot to pick out the parts I needed, then building on it by adding the CFG system and all the forwards/natives. Without these two, the Portable NPC System would never have come to exist in the first place; they deserve just as much credit as I do for this thing, if not more.
- **[Kenzzer](https://github.com/Kenzzer)**, the creator of **[CBaseNPC](https://github.com/TF2-DMB/CBaseNPC?tab=readme-ov-file)**, without which none of this would even have been possible.

## *Known Bugs/Limitations*
- Huntsman arrows are not able to headshot NPCs. I have absolutely no idea how to fix this, if anybody might know how I would happily accept a pull request.
- TF2 conditions cannot be applied to NPCs. I will not be writing a workaround for this as it would take way too long and ultimately not be very useful, you're better off writing the functionality of the condition you need into your own custom NPC logic.
- A lot of very specific/niche weapon attributes do not work against NPCs. As I continue to work on this plugin, I will gradually make more of these non-functioning attributes compatible with NPCs, but this is not a guarantee.
- NPCs cannot be airblasted. I may or may not add this functionality in the future, no promises.
