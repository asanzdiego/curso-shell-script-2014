#! /bin/bash

echo "**************************"
echo "* PUSH CHANGES TO GITHUB *"
echo "**************************"

git status

read -p "You want to continue? [y|*N*]: " OPTION

if [ "$OPTION" == "y" ]; then

    read -p "Write the commit message: " MESSAGE

    git add . && \
    git commit -m "$MESSAGE" && \
    git push
fi
