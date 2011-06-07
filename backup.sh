#!/bin/bash

# ### Über dieses Skript
# Dieses Script dient dem Zweck, die Inhalte des Studienführers Physik der ZaPF zu sichern.
# Dazu wird ein Skript des Projekts wikiteam genutzt, das automatisch alle Inhalte sichert.
#
# Mehr Informationen gibt es in der Datei README.md

## Zum Debuggen diese Zeile einkommentieren:
set -x

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
