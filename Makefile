OPENSCAD=/usr/bin/openscad
SRC_DIR=./src
OUT_DIR=./stl
SRC_FILE=applique.scad

clean: 
	@rm -rf $(OUT_DIR)

init:
	@mkdir -p $(OUT_DIR)

rail_build:
	$(OPENSCAD) -D 'step="rail"' -o $(OUT_DIR)/rail.stl $(SRC_DIR)/$(SRC_FILE)

applique_build:
	$(OPENSCAD) -D 'step="applique"' -o $(OUT_DIR)/applique.stl $(SRC_DIR)/$(SRC_FILE)

all_local: clean init rail_build applique_build

all_container: rail_build applique_build