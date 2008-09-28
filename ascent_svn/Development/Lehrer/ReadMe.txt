
COPYRIGHT BY NIGHTBLIZARD


Packt das Script in den Ordner Scripts (Nicht Scripts_bin). Sollte dieser nicht existieren erstellt ihn.
Geht jetzt in die Ascent-world.conf und sucht den Eintrag


"
<ScriptBackends LUA="0"
                AS="0">
"


Sollte bei LUA eine 0 stehen ersetzt diese durch einen "1" und speichert ab.
Geht jetzt in das Script und ändert die Infos bei

"
local Trainerid = 1234 --1234 durch eure NPCID ersetzen!
"

speichern und fertig.