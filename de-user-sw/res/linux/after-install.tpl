#!/bin/bash

# Link to the binary
ln -sf '/opt/askos-user/askos-user' '/usr/bin/askos-user'

# SUID chrome-sandbox for Electron 5+
# Remove this entire file (after-install.tpl) and remove the reference in
# package.json once this change has been upstreamed so we go back to the copy
# from upstream.
# https://github.com/electron-userland/electron-builder/pull/4163
#chmod 4755 '/opt/hamonikr-support/chrome-sandbox' || true



update-mime-database /usr/share/mime || true
update-desktop-database /usr/share/applications || true

chmod +x /usr/share/applications/${executable}.desktop

cp /usr/share/applications/${executable}.desktop /etc/skel/.config/autostart



# for u in $(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)
# do
#     cp /usr/share/applications/${executable}.desktop $HOME/Desktop/
#     chown $u:$u /home/$u/Desktop/${executable}.desktop
# done

