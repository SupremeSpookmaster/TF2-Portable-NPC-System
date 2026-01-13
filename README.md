<img width="998" height="756" alt="PNPCS Logo render 1" src="https://github.com/user-attachments/assets/08729b82-f9b7-4f6d-8662-6eb21a635b0d" />

The Portable NPC System, or PNPCS, is a helper extension designed to allow developers to dynamically create and deploy their own custom NPCs with ease. It offers a very wide range of natives and forwards, as well as extensive configuration options to allow for maximum control.

## *Installation Guide*
1. Install the **prerequisites**.
2. Download the **latest release Installation Build. (LINK PENDING)**
3. Drag-and-drop the contents of the zip file to your server's `tf` folder.
4. The Portable NPC System is now active on your server!

## *IMPORTANT DISCLAIMERS*
1. Many SourceMod plugins utilize custom damage sources, such as custom explosions or laser beams. They may also utilize custom on-hit effects, such as "when X target is damaged my my cool weapon, they take knockback". Regardless of whether it's custom damage or a custom on-hit effect, you will find that many of them were only coded with clients in mind, and will therefore not work against NPCs. This is not the fault of the Portable NPC System, but poorly-coded plugins. To make plugins compatible with NPCs, see the **[NPC Compatibility Guide](https://github.com/SupremeSpookmaster/TF2-Portable-NPC-System/wiki/NPC-Compatibility-Guide)**.
3. One major issue with NPCs in TF2 is that melee weapons treat them the same as walls. As a result, while melee weapons *can* damage NPCs, the impact sound is *always* the sound of a melee weapon hitting a metal wall. The Portable NPC System fixes this by implementing its own custom melee hitreg. This hitreg functions identically to TF2's actual melee hitreg, but simulates melee bounds and range on its own, using TF2's default range and bounds modified by the weapon's bounds and range attributes. If you wish to use TF2's vanilla hitreg, you may disable the custom hitreg in `data/pnpc/settings.cfg`, though I advise against this as there's really no reason to use TF2's default melee hitreg.
4. Another major issue with NPCs in TF2 is that they block explosions. For example: if you fire a rocket at an NPC, that NPC will take damage, but anything behind it will not, even if they are within the blast radius. The Portable NPC System gets around this by simulating all of TF2's explosions manually. These explosions function *almost* identically to TF2's explosions with some very minor exceptions, but if, for whatever reason, you want to turn off the simulation in favor of using TF2's vanilla explosions, you may do so in `data/pnpc/settings.cfg`. Again, I advise against this.

## *Making NPCs*
An extensive guide will be written at a later date.

## *Prerequisites*
- **[SourceMod 1.13.7216+](https://www.sourcemod.net/downloads.php)**
- **[CBaseNPC](https://github.com/TF2-DMB/CBaseNPC?tab=readme-ov-file)**
- **[TF2 Custom Attributes](https://forums.alliedmods.net/showthread.php?p=2703773)**
- **[TF2Items](https://github.com/asherkin/TF2Items)**
- **[TF2Attributes](https://github.com/FlaminSarge/tf2attributes)**
- **RECOMMENDED: [Queue.inc](https://forums.alliedmods.net/showthread.php?t=319495)** - Not required to function, but *is* required to compile the plugin.

## *Special thanks to...*
- **[Artvin](https://github.com/artvin01)** and **[Batfoxkid](https://github.com/Batfoxkid)**, the creators of ***[TF2 Zombie Riot](https://github.com/artvin01/TF2-Zombie-Riot)***, which was my one of my inspirations for creating the Portable NPC System. Most of the more confusing NPC logic that I was unable to figure out on my own was written by reverse-engineering Zombie Riot; Artvin in specific warned me of a number of bizarre bugs with NPCs in TF2, which I likely would not have noticed on my own. Without these two and their beautiful game mode, the Portable NPC System would never have come to exist in the first place; they deserve just as much credit as I do for this thing.
- **[Kenzzer](https://github.com/Kenzzer)**, the creator of **[CBaseNPC](https://github.com/TF2-DMB/CBaseNPC?tab=readme-ov-file)**, without which none of this would even have been possible.

## *Known Bugs/Limitations*
Ranked in order of most to least impactful:
- NPCs require a nav mesh in order to move. Not all maps *have* a nav mesh. You can fix this by generating navs for each of your server's maps. However, keep in mind that meshes generated in this way are far from perfect; many maps will have areas where the nav simply fails to generate. NPCs have a very difficult time entering these areas, and upon doing so, are unable to move at all. The only solution to this is to tailor the nav meshes of every map your server runs, which is incredibly tedious.
- NPCs do not activate triggers, which can result in a whole bunch of small problems, such as the NPC getting stuck behind doors, or being unable to use teleport triggers.
- Huntsman arrows are not able to headshot NPCs. I have absolutely no idea why, I would happily accept a pull request if anybody might know how to fix this.
- Some projectiles phase through NPCs assigned to TFTeam_Spectator, and all projectiles phase through NPCs assigned to TFTeam_Unassigned. I tried fixing this via CollisionHook, but that did not work.
- Sandman balls, flying guillotines, and all jars (jarate, milk, gas) have a rare chance to sometimes bounce off of NPCs harmlessly. Again, I would happily accept a pull request from anyone who knows how to fix this.
- NPCs cannot be airblasted (their projectiles CAN be, however). I might fix this some day if one of my personal projects makes it necessary for airblast to work against NPCs, but for the time being, I will not be changing this.
- A lot of very specific/niche weapon attributes do not work against NPCs. Inevitably, I will end up making certain attributes compatible for my own personal projects, but this is by no means a guarantee that every attribute will eventually be fixed.
- TF2 conditions cannot be applied to NPCs. I will not be writing a workaround for this as it would take way too long and ultimately not be very useful, you're better off writing the functionality of the condition you need into your own custom NPC logic.
