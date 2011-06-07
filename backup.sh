#!/bin/bash

# ### About this script
# Dieses Script dient dem Zweck, die Inhalte des Studienführers Physik der ZaPF zu sichern.
# Die Internetseite des Studienführers ist <http://studienführer-physik.de>.
# Dazu wird ein Skript des Projekts wikiteam genutzt, das automatisch alle Inhalte sichert.
#
# ### Author
# Philipp Klaus <philipp.klaus →AT→ gmail.com>
# 
# ### Links / Quellen
# * How to backup without access to the wiki server: <http://code.google.com/p/wikiteam/wiki/FAQ>

## zum debuggen diese Zeile einkommentieren:
#set -x

## ----- Konfiguration:
BASE_URL="https://www.fs-maphy.uni-hannover.de"
#EXPORT_URL=$BASE_URL"/w/index.php5?title=Spezial:Exportieren"
API_URL=$BASE_URL"/w/api.php"
BACKUP_FOLDER="studienfuehrer-$(date +%Y-%m-%d)"
DUMPGENERATOR_TOOL_URL="http://wikiteam.googlecode.com/svn/trunk/dumpgenerator.py"
DUMPGENERATOR_TOOL="dumpgenerator.py"

## ----- Befehle:
#svn checkout http://wikiteam.googlecode.com/svn/trunk/ wikiteam
#wget $DUMGENERATOR_TOOL_URL
curl -C - -O $DUMPGENERATOR_TOOL_URL
## Hier passiert die eigentliche Arbeit, das Backup des Wikis:
python $DUMPGENERATOR_TOOL --api=$API_URL --xml --images --logs --path=$BACKUP_FOLDER
tar czvf $BACKUP_FOLDER.tar.gz $BACKUP_FOLDER/*
## Nach dem erstellen der gepackten Datei können wir den Ordner löschen:
rm -rf $BACKUP_FOLDER
