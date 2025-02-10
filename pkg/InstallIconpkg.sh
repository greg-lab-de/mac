#!/bin/bash

# URL der .pkg-Datei
PKG_URL="https://github.com/greg-lab-de/mac/releases/download/production/Icons.pkg"
# Zielverzeichnis
PKG_FILE="/tmp/Icons.pkg"

# Herunterladen der .pkg-Datei
curl -L "$PKG_URL" -o "$PKG_FILE"

# Überprüfen, ob der Download erfolgreich war
if [ -f "$PKG_FILE" ]; then
    echo "Download erfolgreich: $PKG_FILE"
    
    # Installation der .pkg-Datei
    sudo installer -pkg "$PKG_FILE" -target /
    
    # Überprüfen, ob die Installation erfolgreich war
    if [ $? -eq 0 ]; then
        echo "Installation erfolgreich."
    else
        echo "Fehler bei der Installation."
    fi
else
    echo "Fehler beim Download der Datei."
fi