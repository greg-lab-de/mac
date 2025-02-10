#!/bin/bash

# URL der .pkg-Datei (verwende GitHub Releases oder einen direkten Download-Link)
PKG_URL="https://github.com/greg-lab-de/mac/releases/download/v1.0/Icons.pkg"

# Speicherort der heruntergeladenen Datei
PKG_FILE="/Library/Baseline/Icons.pkg"

# Funktion für Logging
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [Baseline] $1"
}

log "Starte Download von $PKG_URL ..."

# Datei herunterladen und Fehler abfangen
curl -L --silent --fail "$PKG_URL" -o "$PKG_FILE"
if [ $? -ne 0 ]; then
    log "❌ Fehler: Download fehlgeschlagen! Prüfe die URL oder ob die Datei existiert."
    exit 1
fi

log "✅ Download erfolgreich: $PKG_FILE"

# Prüfen, ob die Datei wirklich existiert
if [ ! -f "$PKG_FILE" ]; then
    log "❌ Fehler: Paketdatei nicht gefunden!"
    exit 1
fi

log "🚀 Starte Installation ..."

# Installation starten
sudo installer -pkg "$PKG_FILE" -target /
if [ $? -eq 0 ]; then
    log "✅ Installation erfolgreich."
    exit 0
else
    log "❌ Fehler bei der Installation."
    exit 1
fi
