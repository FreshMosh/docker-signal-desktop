# Signal Desktop in a Docker (SDIAD)

## Usage

```
# Wayland
docker run --rm -ti \
    --cap-add=SYS_ADMIN \
    -e XDG_RUNTIME_DIR=/tmp \
    -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
    -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY  \
    --user=$(id -u):$(id -g) \
    signal:latest
```

```
# X11
docker run --rm -ti \
    --cap-add=SYS_ADMIN \
    -e DISPLAY=${DISPLAY} \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --user=$(id -u):$(id -g) \
    signal:latest
```