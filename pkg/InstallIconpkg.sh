#!/bin/bash

# URL der .pkg-Datei
PKG_URL="https://github.com/greg-lab-de/mac/blob/main/pkg/Icons.pkg"

# Speicherort der heruntergeladenen Datei
PKG_FILE="/tmp/Icons.pkg"

# Herunterladen der .pkg-Datei
curl -L "$PKG_URL" -o "$PKG_FILE"

# Prüfen, ob der Download erfolgreich war
if [ $? -eq 0 ]; then
    echo "Download erfolgreich: $PKG_FILE"
    
    # Installation der .pkg-Datei
    sudo installer -pkg "$PKG_FILE" -target /
    
    if [ $? -eq 0 ]; then
        echo "Installation erfolgreich."
    else
        echo "Fehler bei der Installation."
        exit 1
    fi
else
    echo "Fehler beim Herunterladen der Datei."
    exit 1
fi