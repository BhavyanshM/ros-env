XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

docker run -it --user drone\
    --privileged \
    --net=host \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v $HOME/.ssh:/home/$( id -u -n)/.ssh:ro \
    -v $SSH_AUTH_SOCK:/ssh-agent \
    --user $(id -u):$(id -g) \
    --mount type=tmpfs,destination=/home/$( id -u -n) \
    -e "SSH_AUTH_SOCK=/ssh-agent" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --volume=$(pwd):/home/$( id -u -n)/scripts/ \
    --runtime=nvidia \
    melodic_nvidia \
    bash

