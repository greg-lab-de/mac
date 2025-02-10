#!/bin/bash

# URL der .pkg-Datei (achte darauf, dass die URL direkt auf die Datei verweist!)
PKG_URL="https://raw.githubusercontent.com/greg-lab-de/mac/main/pkg/Icons.pkg"

# Speicherort der heruntergeladenen Datei (Baseline kann diesen Pfad überschreiben)
PKG_FILE="/Library/Application Support/Baseline/Icons.pkg"

# Funktion für Logging
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [Baseline] $1"
}

log "Starte Download von $PKG_URL ..."

# Herunterladen der .pkg-Datei mit korrektem Exit-Code für Baseline
curl -L "$PKG_URL" -o "$PKG_FILE" --silent --fail
if [ $? -ne 0 ]; then
    log "Fehler beim Herunterladen der Datei!"
    exit 1
fi

log "Download erfolgreich: $PKG_FILE"

# Prüfen, ob die Datei existiert
if [ ! -f "$PKG_FILE" ]; then
    log "Fehler: Paketdatei nicht gefunden!"
    exit 1
fi

log "Starte Installation ..."

# Installation der .pkg-Datei
sudo installer -pkg "$PKG_FILE" -target /
if [ $? -eq 0 ]; then
    log "Installation erfolgreich."
    exit 0
else
    log "Fehler bei der Installation."
    exit 1
fi
