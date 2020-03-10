# Parametric wall lamp with rail mount

## Dependencies

You need to install openscad and build-essential or to have a working docker installation

## Build
### Build Locally
```sh
git clone ...
cd OSFP_lamp
make all_local
```
### Build Docker
```sh
git clone ...
cd OSFP_lamp
docker build -t openscad_builder .
docker run -it -v $(pwd)/stl:/app/stl openscad_builder
sudo chown -R $(whoami):$(id -g -n) stl
```