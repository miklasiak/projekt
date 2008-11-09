DROP TABLE IF EXISTS `command_overrides`;

CREATE TABLE `command_overrides` (
  `command_name` varchar(100) character set latin1 NOT NULL,
  `access_level` varchar(10) character set latin1 NOT NULL,
  PRIMARY KEY  (`command_name`),
  UNIQUE KEY `a` (`command_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Commands System';


INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug infront', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug showreact', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug aimove', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug dist', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug face', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug moveinfo', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug setbytes', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug getbytes', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug unroot', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug root', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug landwalk', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug waterwalk', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug castspell', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug castself', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug castspellne', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug fade', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug threatMod', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug calcThreat', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug threatList', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug gettptime', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug itempushresult', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug setbit', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug setvalue', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug aispelltestbegin', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug aispelltestcontinue', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug aispelltestskip', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug dumpcoords', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug sendpacket', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug sqlquery', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug rangecheck', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug setallratings', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('admin masssummon', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('commands', 'c');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('help', 'c');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('announce', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('wannounce', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('appear', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('summon', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('ban character', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('unban character', 'o');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('kick', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('kill', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('killplr', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('revive', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('reviveplr', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('demorph', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('mount', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('dismount', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gm', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gm on', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gm off', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gps', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('info', 'c');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('worldport', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('server save', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('server saveall', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('start', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character additem', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character removeitem', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('invincible', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('invisible', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character resetreputation', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character resetspells', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character resettalents', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character resetskills', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character learn', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character unlearn', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character getskillinfo', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character learnskill', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character advanceskill', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character removeskill', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character increaseweaponskill', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('playerinfo', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('levelup', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify hp', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify gender', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify mana', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify rage', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify energy', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify level', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify armor', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify holy', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify fire', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify nature', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify frost', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify shadow', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify arcane', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify damage', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify scale', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify gold', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify speed', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify nativedisplayid', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify displayid', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify flags', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify faction', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify dynamicflags', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify talentpoints', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify happiness', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify spirit', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify boundingraidius', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify combatreach', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify emotestate', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modify bytes', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint add', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint show', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint hide', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint delete', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint movehere', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint flags', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint waittime', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint emote', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint skin', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint change', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint info', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint movetype', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint generate', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint save', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint deleteall', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('waypoint addfly', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gmticket', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gmticket get', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gmticket getid', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gmticket delid', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject select', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject delete', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject spawn', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject info', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject activate', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject enable', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject scale', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject animprogress', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject export', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject move', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gobject rotate', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground setbgscore', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground startbg', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground pausebg', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground bginfo', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground setworldstate', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground playsound', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground setbfstatus', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground leave', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc vendoradditem', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc vendorremoveitem', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc flags', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc emote', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc delete', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc info', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc addagent', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc listagent', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc say', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc yell', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc come', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc return', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc spawn', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc spawnlink', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc posses', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc unposses', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc select', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat status', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat taxi', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat cooldown', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat casttime', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat god', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat power', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat fly', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat land', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat explore', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat flyspeed', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat stack', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('cheat triggerpass', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('account', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('account level', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('account mute', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('account unmute', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('honor', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('honor addpoints', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('honor addkills', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('honor globaldailyupdate', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('honor singledailyupdate', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('honor pvpcredit', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest addboth', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest addfinish', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest addstart', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest delboth', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest delfinish', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest delstart', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest complete', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest finisher', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest item', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest list', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest load', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest lookup', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest giver', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest remove', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest reward', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest status', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest spawn', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('quest start', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('pet', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('pet createpet', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('pet renamepet', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('pet addspell', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('pet removespell', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('recall', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('recall list', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('recall port', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('recall add', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('recall del', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('recall portplayer', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('guild', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('guild create', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('guild rename', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('guild members', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('guild removeplayer', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('guild disband', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('getpos', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('clearcooldowns', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('removeauras', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('paralyze', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('unparalyze', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('setmotd', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('additemset', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gotrig', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('exitinstance', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('server reloadtable', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('server shutdown', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('server restart', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gm allowwhispers', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gm blockwhispers', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character advanceallskills', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('killbyplayer', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('admin castall', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('admin dispelall', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('modperiod', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('nps npcfollow', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('nps nullfollow', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc formationlink1', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc formationlink2', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('npc formationclear', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('admin playall', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('ban ip', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('unban ip', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('renamechar', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('forcerenamechar', 'o');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('getstanding', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('setstanding', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('lookupitem', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('lookupquest', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('lookupcreature', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('server rehash', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('createarenateam', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('whisperblock', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('logcomment', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('showitems', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('removesickness', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug testlos', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug testindoor', 'v');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('fixscale', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('addtrainerspell', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character showskills', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gmannounce', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground forcestart', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('battleground getqueue', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug getheight', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('debug getpos', 'd');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('admin', 'z');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('ban', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('unban', 'o');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('kick byplayer', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('server', 'm');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('character', 's');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gmticket list', 'g');

INSERT INTO command_overrides
   (`command_name`, `access_level`)
VALUES
   ('gmticket comment', 'g');