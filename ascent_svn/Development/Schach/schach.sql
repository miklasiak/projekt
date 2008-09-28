INSERT INTO creature_names (entry, name, subname, info_str, Flags1, type, family, rank, male_displayid, female_displayid, male_displayid2, female_displayid2, civilian, leader) VALUES ('198765','Schacheventmeister','Battle Chessmaster','','1','7','0','2','21403','0','0','0','0','1');
insert into `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `mountdisplayid`, `equipmodel1`, `equipinfo1`, `equipslot1`, `equipmodel2`, `equipinfo2`, `equipslot2`, `equipmodel3`, `equipinfo3`, `equipslot3`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `death_state`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`) values('198765','70','70','35','5000','5000','0','1','3','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','0','0','0','2.5','8','14','0','0','0','0','0','0');

INSERT INTO creature_names (entry, name, subname, info_str, Flags1, type, family, rank, male_displayid, female_displayid, male_displayid2, female_displayid2, civilian, leader) VALUES ('198766','Chessi','LUAppArc Scripting Project','','0','1','0','2','19735','0','0','0','1','0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `mountdisplayid`, `equipmodel1`, `equipinfo1`, `equipslot1`, `equipmodel2`, `equipinfo2`, `equipslot2`, `equipmodel3`, `equipinfo3`, `equipslot3`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `death_state`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`) VALUES 
(198766, 70, 70, 35, 100000, 100000, 100000, 0.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36000, 0, 0, 0, 0, 0, 0, 0, 1, 0, '0', 0, 0, 0, 0, 2.5, 8, 14, 0, 0, 0, 0, 0, 0);

INSERT INTO npc_text
  (entry, prob0, text0_0, text0_1, lang0, em0_0, em0_1, em0_2, em0_3, em0_4, em0_5, prob1, text1_0, text1_1, lang1, em1_0, em1_1, em1_2, em1_3, em1_4, em1_5, prob2, text2_0, text2_1, lang2, em2_0, em2_1, em2_2, em2_3, em2_4, em2_5, prob3, text3_0, text3_1, lang3, em3_0, em3_1, em3_2, em3_3, em3_4, em3_5, prob4, text4_0, text4_1, lang4, em4_0, em4_1, em4_2, em4_3, em4_4, em4_5, prob5, text5_0, text5_1, lang5, em5_0, em5_1, em5_2, em5_3, em5_4, em5_5, prob6, text6_0, text6_1, lang6, em6_0, em6_1, em6_2, em6_3, em6_4, em6_5, prob7, text7_0, text7_1, lang7, em7_0, em7_1, em7_2, em7_3, em7_4, em7_5)
VALUES
  (20010, 1, "Hello $c, you realy want to play Chess? Choose an option to start the Game.", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0);

INSERT INTO npc_text_localized
  (entry, language_code, text0, text0_1, text1, text1_1, text2, text2_1, text3, text3_1, text4, text4_1, text5, text5_1, text6, text6_1, text7, text7_1)
VALUES
  (20010, "deDE", "Hallo $c, du willst also wirklich Schach spielen? So w?hle eine Option, um das Spiel zu starten.", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

INSERT INTO npc_text
  (entry, prob0, text0_0, text0_1, lang0, em0_0, em0_1, em0_2, em0_3, em0_4, em0_5, prob1, text1_0, text1_1, lang1, em1_0, em1_1, em1_2, em1_3, em1_4, em1_5, prob2, text2_0, text2_1, lang2, em2_0, em2_1, em2_2, em2_3, em2_4, em2_5, prob3, text3_0, text3_1, lang3, em3_0, em3_1, em3_2, em3_3, em3_4, em3_5, prob4, text4_0, text4_1, lang4, em4_0, em4_1, em4_2, em4_3, em4_4, em4_5, prob5, text5_0, text5_1, lang5, em5_0, em5_1, em5_2, em5_3, em5_4, em5_5, prob6, text6_0, text6_1, lang6, em6_0, em6_1, em6_2, em6_3, em6_4, em6_5, prob7, text7_0, text7_1, lang7, em7_0, em7_1, em7_2, em7_3, em7_4, em7_5)
VALUES
  (20011, 1, "Please, choose your option.", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0);

INSERT INTO npc_text_localized
  (entry, language_code, text0, text0_1, text1, text1_1, text2, text2_1, text3, text3_1, text4, text4_1, text5, text5_1, text6, text6_1, text7, text7_1)
VALUES
  (20011, "deDE", "Bitte w?hle eine Option.", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

INSERT INTO npc_text
  (entry, prob0, text0_0, text0_1, lang0, em0_0, em0_1, em0_2, em0_3, em0_4, em0_5, prob1, text1_0, text1_1, lang1, em1_0, em1_1, em1_2, em1_3, em1_4, em1_5, prob2, text2_0, text2_1, lang2, em2_0, em2_1, em2_2, em2_3, em2_4, em2_5, prob3, text3_0, text3_1, lang3, em3_0, em3_1, em3_2, em3_3, em3_4, em3_5, prob4, text4_0, text4_1, lang4, em4_0, em4_1, em4_2, em4_3, em4_4, em4_5, prob5, text5_0, text5_1, lang5, em5_0, em5_1, em5_2, em5_3, em5_4, em5_5, prob6, text6_0, text6_1, lang6, em6_0, em6_1, em6_2, em6_3, em6_4, em6_5, prob7, text7_0, text7_1, lang7, em7_0, em7_1, em7_2, em7_3, em7_4, em7_5)
VALUES
  (20012, 1, "Please, choose your opponent.", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0);

INSERT INTO npc_text_localized
  (entry, language_code, text0, text0_1, text1, text1_1, text2, text2_1, text3, text3_1, text4, text4_1, text5, text5_1, text6, text6_1, text7, text7_1)
VALUES
  (20012, "deDE", "Bitte w?hle deinen Gegenspieler.", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

INSERT INTO npc_text
  (entry, prob0, text0_0, text0_1, lang0, em0_0, em0_1, em0_2, em0_3, em0_4, em0_5, prob1, text1_0, text1_1, lang1, em1_0, em1_1, em1_2, em1_3, em1_4, em1_5, prob2, text2_0, text2_1, lang2, em2_0, em2_1, em2_2, em2_3, em2_4, em2_5, prob3, text3_0, text3_1, lang3, em3_0, em3_1, em3_2, em3_3, em3_4, em3_5, prob4, text4_0, text4_1, lang4, em4_0, em4_1, em4_2, em4_3, em4_4, em4_5, prob5, text5_0, text5_1, lang5, em5_0, em5_1, em5_2, em5_3, em5_4, em5_5, prob6, text6_0, text6_1, lang6, em6_0, em6_1, em6_2, em6_3, em6_4, em6_5, prob7, text7_0, text7_1, lang7, em7_0, em7_1, em7_2, em7_3, em7_4, em7_5)
VALUES
  (20013, 1, "The challenge...", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0);

INSERT INTO npc_text_localized
  (entry, language_code, text0, text0_1, text1, text1_1, text2, text2_1, text3, text3_1, text4, text4_1, text5, text5_1, text6, text6_1, text7, text7_1)
VALUES
  (20013, "deDE", "Die Herausforderung...", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
