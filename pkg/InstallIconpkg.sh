#!/bin/bash

# URL der .pkg-Datei (verwende GitHub Releases oder einen direkten Download-Link)
PKG_URL="https://github.com/greg-lab-de/mac/releases/download/production/Icons.pkg"

# Speicherort der heruntergeladenen Datei
PKG_FILE="/Library/Baseline/Icons.pkg"

# Speicherort der Log-Datei
LOG_DIR="/Library/IntuneScripts/Baseline/InitialScripts"
LOG_FILE="$LOG_DIR/install.log"

# Sicherstellen, dass das Log-Verzeichnis existiert
if [ ! -d "$LOG_DIR" ]; then
    sudo mkdir -p "$LOG_DIR"
    sudo chmod 755 "$LOG_DIR"
fi

# Sicherstellen, dass die Log-Datei existiert
if [ ! -f "$LOG_FILE" ]; then
    sudo touch "$LOG_FILE"
    sudo chmod 644 "$LOG_FILE"
fi

# Funktion für Logging
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [Baseline] $1" | tee -a "$LOG_FILE"
}

log "Starte Download von $PKG_URL ..."

# Datei herunterladen und Fehler abfangen
if ! sudo curl -L --silent --fail "$PKG_URL" -o "$PKG_FILE"; then
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
if sudo installer -pkg "$PKG_FILE" -target /; then
    log "✅ Installation erfolgreich."
    exit 0
else
    log "❌ Fehler bei der Installation."
    exit 1
fi