INCLUDES = -I$(top_srcdir)/src/ascent-logonserver \
   -I$(top_srcdir)/src/ascent-realmserver -I$(top_srcdir)/src/ascent-shared -I$(top_srcdir)/src/ascent-voicechat \
   -I$(top_srcdir)/src/ascent-world -I$(srcdir) -I$(srcdir)/../../../../dep/include \
   -I$(srcdir)/../../../../dep/src -I$(srcdir)/../../../../src

AM_CXXFLAGS = -DSCRIPTLIB

lib_LTLIBRARIES = libSunMiscScripts.la

libSunMiscScripts_la_SOURCES = Creatures.cpp \
GameObjects.cpp \
RandomScripts.cpp \
QuelDanasPortal.cpp \
DarkmoonFaireObjects.cpp \
Setup.cpp
