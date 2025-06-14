#!/bin/bash

# Real Path $0
rlpt0=$(realpath "$0")
ParentDir="${rlpt0%/cli/*}"

echo -e "The current path is: \n    $ParentDir"
echo -e "Confirm that the installation begins: [Y/n]"
read -e -p "" -r answer
if [[ $answer =~ ^[Yy]$ ]]; then
    echo "Installation is about to begin:"
else
    echo "Installation has been cancelled.";
    exit 0;
fi


TargetPath="$ParentDir"
sudo unlink /opt/dockge || echo ""
sudo unlink /opt/stacks || echo ""

sudo  ln -s "$TargetPath/dockge"  /opt/dockge
sudo  ln -s "$TargetPath/stacks"  /opt/stacks



cd /opt/dockge

if [ ! -f "./data/common.env" ]; then
cat << EOF > ./data/common.env
# Global  VARIABLE env
# VARIABLE=value #comment

SaveData=
EOF
fi

exit 0;
# cat << EOF > ./data/compose-task.js
# const CommonEvn = "common.env";
# const AppData = "/app/data";
# export const ComposeTask={
#   deploy: [ "compose", "--env-file", \`\${AppData}/\${CommonEvn}\`, "--env-file", ".env", "up", "-d", "--remove-orphans" ],
#   start : [ "compose", "--env-file", \`\${AppData}/\${CommonEvn}\`, "--env-file", ".env", "up", "-d", "--remove-orphans" ],
#   update: [ "compose", "--env-file", \`\${AppData}/\${CommonEvn}\`, "--env-file", ".env", "up", "-d", "--remove-orphans" ],
# }
# EOF

# container_name in compose.yaml
DockgeName='dockge'
# DockgeName='dockge-dockge-1'

docker compose up -d
sleep 5s
docker cp ./data/stack.ts $DockgeName:/app/backend/
docker restart $DockgeName
