export THISDIR=$(pwd)

echo "Updating .pldotfiles ..."
for dir in \
    .spacemacs.d \
    .hammerspoon \
    .ssh/config \
    .tmux.conf \
    .zpreztorc \
    .zshrc 
do
    if [ -d $HOME/$dir ]
    then
        rm -rf $THISDIR/$dir
        mkdir -p $THISDIR/$dir
        cp -r $HOME/$dir/* $THISDIR/$dir
    else
        cp $HOME/$dir $THISDIR/$dir
    fi
done

echo "Committing changes ..." && \
    git status && \
    git add -A && \
    git commit -m "update" && \
    git push

echo "Done git commit and push!"
ls -la
