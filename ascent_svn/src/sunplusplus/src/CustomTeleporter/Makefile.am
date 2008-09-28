INCLUDES += -I$(srcdir) -I$(srcdir)/../../../../dep/include -I$(srcdir)/../../../arcemu-shared
INCLUDES += -I$(srcdir)/../../../arcemu-world -I$(srcdir)/../../../../dep/src

AM_CXXFLAGS = -DSCRIPTLIB

lib_LTLIBRARIES = libExtraScripts.la

libExtraScripts_la_SOURCES = custom_teleporters.cpp \
	morph.cpp \
	skillnpc.cpp \
	teleport.cpp \
	Setup.cpp
