NAME=sdc-vmtools

ifeq ($(VERSION), "")
	@echo "Use gmake"
endif

# Directories
SRC := $(shell pwd)

# Tools
MAKE = make
TAR = tar
UNAME := $(shell uname)
ifeq ($(UNAME), SunOS)
	MAKE = gmake
	TAR = gtar
	CC = gcc
endif

RESTDOWN = restdown

clean:
	@echo "Cleaning"
	rm -fr cache

all:
	bin/build-image

#Used for packaging for illumos/OmniOS
DESTDIR=cache
install:
	mkdir -p $(DESTDIR)/lib
	cp -r src/illumos/lib/smartdc $(DESTDIR)/lib
	mkdir -p $(DESTDIR)/etc/rc3.d
	mv $(DESTDIR)/lib/smartdc/joyent_rc.local $(DESTDIR)/etc/rc3.d/Ssmartdc_guest

uninstall:
	rm -r $(DESTDIR)/lib/smartdc
	rm $(DESTDIR)/etc/rc3.d/Ssmartdc_guest

.PHONY: clean iso tar all
