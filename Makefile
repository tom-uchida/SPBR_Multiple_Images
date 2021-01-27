###########################################
#####        Makefile for SPBR        #####
#####        2017/03/12  S. Tanaka    #####
#####        2020/09/29  T. Uchida    #####
###########################################

# Installation directory
INSTALL_DIR=$(HOME)/local/bin
SPBR_EXE=spbr_loop_image
# SPBR_EXE=spbr

##### Build all executable files #####
build:
# Create Makefile.kvs ==> Replaced with sh config_spbr.sh
#	kvsmake -g sopbr_tmp
# SPBR
	kvsmake clean
	cp ./MAIN/spbr_main.cpp ./main.cpp
	kvsmake	
	mv sopbr_tmp $(SPBR_EXE)
# OPBR
	kvsmake clean
	cp ./MAIN/opbr_main.cpp ./main.cpp
	kvsmake
	mv sopbr_tmp opbr

##### Install the Built executable files #####
install:
	@if [ ! -d $(INSTALL_DIR) ]; \
		then echo "mkdir -p $(INSTALL_DIR)"; mkdir -p $(INSTALL_DIR); \
	fi
	cp $(SPBR_EXE) $(INSTALL_DIR)
	cp opbr $(INSTALL_DIR)

##### Full automatic installation (Build + Install) #####
autoinstall:
# Create Makefile.kvs ==> Replaced with sh config_spbr.sh
#	kvsmake -g sopbr_tmp
# SPBR
	kvsmake clean
	cp ./MAIN/spbr_main.cpp ./main.cpp
	kvsmake	
	mv sopbr_tmp $(SPBR_EXE)
# OPBR
	kvsmake clean
	cp ./MAIN/opbr_main.cpp ./main.cpp
	kvsmake
	mv sopbr_tmp opbr
# install
	@if [ ! -d $(INSTALL_DIR) ]; \
		then echo "mkdir -p $(INSTALL_DIR)"; mkdir -p $(INSTALL_DIR); \
	fi
	cp $(SPBR_EXE) $(INSTALL_DIR)
	cp opbr $(INSTALL_DIR)


########################################
# Building executable files one by one #
########################################

# SPBR
spbr:
# Create Makefile.kvs ==> Replaced with sh config_spbr.sh
#	kvsmake -g sopbr_tmp
	kvsmake clean
	cp ./MAIN/spbr_main.cpp ./main.cpp
	kvsmake	
	mv sopbr_tmp $(SPBR_EXE)

spbr_install:
	@if [ ! -d $(INSTALL_DIR) ]; \
		then echo "mkdir -p $(INSTALL_DIR)"; mkdir -p $(INSTALL_DIR); \
	fi
	cp $(SPBR_EXE) $(INSTALL_DIR)

# OPBR
opbr:
# Create Makefile.kvs ==> Replaced with sh config_spbr.sh
#	kvsmake -g sopbr_tmp
	kvsmake clean
	cp ./MAIN/opbr_main.cpp ./main.cpp
	kvsmake
	mv sopbr_tmp opbr

opbr_install:
	@if [ ! -d $(INSTALL_DIR) ]; \
		then echo "mkdir -p $(INSTALL_DIR)"; mkdir -p $(INSTALL_DIR); \
	fi
	cp opbr $(INSTALL_DIR)


# TOOL (Convert2Binary)
tool:
	cd CONVERT2BINARY; make 
	cd PLY_SUPPORT/PLYTHIN; make 

tool_install:
	cd CONVERT2BINARY; make install 
	cd PLY_SUPPORT/PLYTHIN; make install

############
# Cleaning #
############

# Clean temporary files in this directory
clean:
	kvsmake clean
	rm -f sopbr_tmp
	rm -f $(SPBR_EXE)
	rm -f spbr spbr_ba opbr
	rm -f *.o
	rm -f *~
	rm -f \#*

# Clean 3d data files in this directory
dataclean:
	rm -f *.pbr *.spbr
	rm -f *.ply

# Clean image files in this directory
imgclean:
	rm -f  *.bmp *.ppm *.pgm

# clean all, including temporary files in the sub-directories
cleanall:
	kvsmake clean
	rm -f sopbr_tmp
	rm -f $(SPBR_EXE)
	rm -f spbr spbr_ba opbr
	rm -f pbr2014 pbr 
	rm -f pbr2014bin 
	rm -f ptbr 
	rm -f pbr_cpu ptbr_cpu 
	rm -f *.o
	rm -f *~
	rm -f \#*
#	rm -f .param.spbr
#
	cd CONVERT2BINARY; make clean
	cd PLY_SUPPORT/PLYTHIN; make clean
#
	cd MAIN; make clean
#
	cd DOC; make clean
#
	cd SPBR_DATA; make clean
	cd PLY_DATA; make clean
#
	rm -f *.pbr *.spbr
#
	rm -f *.ply
#
	rm -f  *.bmp *.ppm *.pgm


# Automatic uninstallation
uninstall:
	cd $(INSTALL_DIR); rm -f $(SPBR_EXE); rm -f spbr spbr_ba opbr
	cd CONVERT2BINARY; make uninstall
	cd PLY_SUPPORT/PLYTHIN; make uninstall

# Tests for ASCII data
test1:
	./$(SPBR_EXE) ./SPBR_DATA/bunny05M.spbr 

test2:
	./$(SPBR_EXE) ./PLY_DATA/sphere05M_ASCII_XYZNzNyNz.ply

test3:
	./opbr ./SPBR_DATA/bunny05M.spbr 

test4:
	./opbr ./PLY_DATA/sphere05M_ASCII_XYZNzNyNz.ply

# Tests binary data
test5: 
	./$(SPBR_EXE) ./SPBR_DATA/bunny05Mbin.spbr 

test6: 
	./$(SPBR_EXE) ./PLY_DATA/breast_BIN_XYZNxNyNzRGBA.ply

test7: 
	./opbr ./SPBR_DATA/bunny05Mbin.spbr 

test8: 
	./opbr ./PLY_DATA/breast_BIN_XYZNxNyNzRGBA.ply

# Test of brightness adjustment
test9:
	./$(SPBR_EXE) ./SPBR_DATA/jack05M_BA.spbr
