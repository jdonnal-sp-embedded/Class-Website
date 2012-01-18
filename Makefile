
SHELL = /bin/sh

#### Start of system configuration section. ####

srcdir = /home/jdonnal/.rvm/src/ruby-1.8.7-p357/ext/readline
topdir = /home/jdonnal/.rvm/rubies/ruby-1.8.7-p357/lib/ruby/1.8/i686-linux
hdrdir = $(topdir)
VPATH = $(srcdir):$(topdir):$(hdrdir)
prefix = $(DESTDIR)/home/jdonnal/.rvm/rubies/ruby-1.8.7-p357
exec_prefix = $(prefix)
sharedstatedir = $(prefix)/com
sitelibdir = $(sitedir)/$(ruby_version)
vendorarchdir = $(vendorlibdir)/$(sitearch)
archdir = $(rubylibdir)/$(arch)
pdfdir = $(docdir)
htmldir = $(docdir)
vendorlibdir = $(vendordir)/$(ruby_version)
mandir = $(datarootdir)/man
dvidir = $(docdir)
infodir = $(datarootdir)/info
sitearchdir = $(sitelibdir)/$(sitearch)
psdir = $(docdir)
localedir = $(datarootdir)/locale
datarootdir = $(prefix)/share
rubylibdir = $(libdir)/ruby/$(ruby_version)
vendordir = $(libdir)/ruby/vendor_ruby
sbindir = $(exec_prefix)/sbin
sysconfdir = $(prefix)/etc
includedir = $(prefix)/include
libexecdir = $(exec_prefix)/libexec
sitedir = $(libdir)/ruby/site_ruby
oldincludedir = $(DESTDIR)/usr/include
localstatedir = $(prefix)/var
datadir = $(datarootdir)
docdir = $(datarootdir)/doc/$(PACKAGE)
libdir = $(exec_prefix)/lib
bindir = $(exec_prefix)/bin

CC = gcc
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -Wl,-R -Wl,$(libdir) -L$(libdir) -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -l$(RUBY_SO_NAME)-static

RUBY_EXTCONF_H = 
CFLAGS   =  -fPIC -g -O2  -fPIC $(cflags) 
INCFLAGS = -I. -I. -I/home/jdonnal/.rvm/rubies/ruby-1.8.7-p357/lib/ruby/1.8/i686-linux -I/home/jdonnal/.rvm/src/ruby-1.8.7-p357/ext/readline
DEFS     = -D_FILE_OFFSET_BITS=64
CPPFLAGS = -DHAVE_READLINE_READLINE_H -DHAVE_READLINE_HISTORY_H -DHAVE_RL_FILENAME_COMPLETION_FUNCTION -DHAVE_RL_USERNAME_COMPLETION_FUNCTION -DHAVE_RL_COMPLETION_MATCHES -DHAVE_RL_DEPREP_TERM_FUNCTION -DHAVE_RL_COMPLETION_APPEND_CHARACTER -DHAVE_RL_BASIC_WORD_BREAK_CHARACTERS -DHAVE_RL_COMPLETER_WORD_BREAK_CHARACTERS -DHAVE_RL_BASIC_QUOTE_CHARACTERS -DHAVE_RL_COMPLETER_QUOTE_CHARACTERS -DHAVE_RL_FILENAME_QUOTE_CHARACTERS -DHAVE_RL_ATTEMPTED_COMPLETION_OVER -DHAVE_RL_LIBRARY_VERSION -DHAVE_RL_EVENT_HOOK -DHAVE_RL_CLEANUP_AFTER_SIGNAL -DHAVE_RL_CLEAR_SIGNALS -DHAVE_RL_VI_EDITING_MODE -DHAVE_RL_EMACS_EDITING_MODE -DHAVE_REPLACE_HISTORY_ENTRY -DHAVE_REMOVE_HISTORY  -D_FILE_OFFSET_BITS=64 
CXXFLAGS = $(CFLAGS) 
ldflags  = -L.  -rdynamic -Wl,-export-dynamic
dldflags = 
archflag = 
DLDFLAGS = $(ldflags) $(dldflags) $(archflag)
LDSHARED = $(CC) -shared
AR = ar
EXEEXT = 

RUBY_INSTALL_NAME = ruby
RUBY_SO_NAME = ruby
arch = i686-linux
sitearch = i686-linux
ruby_version = 1.8
ruby = /home/jdonnal/.rvm/rubies/ruby-1.8.7-p357/bin/ruby
RUBY = $(ruby)
RM = rm -f
MAKEDIRS = mkdir -p
INSTALL = /usr/bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp

#### End of system configuration section. ####

preload = 

libpath = . $(libdir)
LIBPATH =  -L. -L$(libdir) -Wl,-R$(libdir)
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 

extout = 
extout_prefix = 
target_prefix = 
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED) -lreadline -lncurses  -lrt -ldl -lcrypt -lm   -lc
SRCS = readline.c
OBJS = readline.o
TARGET = readline
DLLIB = $(TARGET).so
EXTSTATIC = 
STATIC_LIB = 

BINDIR        = $(bindir)
RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR    = $(sitelibdir)$(target_prefix)
RUBYARCHDIR   = $(sitearchdir)$(target_prefix)

TARGET_SO     = $(DLLIB)
CLEANLIBS     = $(TARGET).so $(TARGET).il? $(TARGET).tds $(TARGET).map
CLEANOBJS     = *.o *.a *.s[ol] *.pdb *.exp *.bak

all:		$(DLLIB)
static:		$(STATIC_LIB)

clean:
		@-$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES)

distclean:	clean
		@-$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		@-$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)

realclean:	distclean
install: install-so install-rb

install-so: $(RUBYARCHDIR)
install-so: $(RUBYARCHDIR)/$(DLLIB)
$(RUBYARCHDIR)/$(DLLIB): $(DLLIB)
	$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
install-rb: pre-install-rb install-rb-default
install-rb-default: pre-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
$(RUBYARCHDIR):
	$(MAKEDIRS) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .cxx .cpp .C .o

.cc.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cxx.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cpp.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.C.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.c.o:
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) -c $<

$(DLLIB): $(OBJS) Makefile
	@-$(RM) $@
	$(LDSHARED) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)



###
readline.o: readline.c $(hdrdir)/ruby.h $(topdir)/config.h $(hdrdir)/defines.h
