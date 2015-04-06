BOOK = using-git
PKGNAME = using-git
TEXINFO_DIR = .

PREFIX = /usr
DATA = /share
DATADIR = $(DATADIR)
INFODIR = $(DATADIR)/info
DOCDIR = $(DATADIR)/doc
LICENSEDIR = $(DATADIR)/licenses

TEXIFLAGS = #--force



.PHONY: all
all:


.PHONY: install
install:

.PHONY: uninstall
uninstall:

.PHONY: clean
clean:
	-rm -r -- bin obj

## Texinfo manual section

.PHONY: doc
all: doc
doc: info pdf ps dvi

.PHONY: info pdf ps dvi
info: $(BOOK).info
pdf: $(BOOK).pdf
ps: $(BOOK).ps
dvi: $(BOOK).dvi

#obj/logo.svg: logo.svg
#	@mkdir -p obj
#	cp "$<" "$@"
#
#obj/logo.pdf: logo.svg
#	@mkdir -p obj
#	rsvg-convert --format=pdf "$<" > "$@"
#
#obj/logo.eps: obj/logo.ps
#	ps2eps "$<"
#
#obj/logo.ps: logo.svg
#	@mkdir -p obj
#	rsvg-convert --format=ps "$<" > "$@"

%.info: $(TEXINFO_DIR)/%.texinfo
	$(MAKEINFO) $(TEXIFLAGS) "$<"

%.pdf: $(TEXINFO_DIR)/%.texinfo
	@mkdir -p obj/pdf
	cd obj/pdf && yes X | texi2pdf $(TEXIFLAGS) "../../$<"
	mv "obj/pdf/$@" "$@"

%.dvi: $(TEXINFO_DIR)/%.texinfo
	@mkdir -p obj/dvi
	cd obj/dvi && yes X | $(TEXI2DVI) $(TEXIFLAGS) "../../$<"
	mv "obj/dvi/$@" "$@"

%.ps: $(TEXINFO_DIR)/%.texinfo
	@mkdir -p obj/ps
	cd obj/ps && yes X | texi2pdf $(TEXIFLAGS) --ps "../../$<"
	mv "obj/ps/$@" "$@"

.PHONY: install-info install-pdf install-dvi install-ps
install: install-info
install-info: $(BOOK).info
	install -Dm644 "$<" -- "$(DESTDIR)$(INFODIR)/$(PKGNAME).info"
install-pdf: $(BOOK).pdf
	install -Dm644 "$<" -- "$(DESTDIR)$(DOCDIR)/$(PKGNAME).pdf"
install-dvi: $(BOOK).dvi
	install -Dm644 "$<" -- "$(DESTDIR)$(DOCDIR)/$(PKGNAME).dvi"
install-ps: $(BOOK).ps
	install -Dm644 "$<" -- "$(DESTDIR)$(DOCDIR)/$(PKGNAME).ps"

.PHONY: uninstall-info uninstall-pdf uninstall-dvi uninstall-ps
uninstall: uninstall-info uninstall-pdf uninstall-dvi uninstall-ps
uninstall-info:
	-rm -- "$(DESTDIR)$(INFODIR)/$(PKGNAME).info"
uninstall-pdf:
	-rm -- "$(DESTDIR)$(DOCDIR)/$(PKGNAME).pdf"
uninstall-dvi:
	-rm -- "$(DESTDIR)$(DOCDIR)/$(PKGNAME).dvi"
uninstall-ps:
	-rm -- "$(DESTDIR)$(DOCDIR)/$(PKGNAME).ps"

.PHONY: clean-texinfo
clean: clean-texinfo
clean-texinfo:
	-rm -r -- *.{info,pdf,ps,dvi}

## License section

.PHONY: install-license
install: install-license
install-license:
	install -d -- "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)"
	install -m644 LICENSE -- "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)"

.PHONY: uninstall-license
uninstall: uninstall-license
uninstall-license:
	-rm -- "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)/LICENSE"
	-rmdir -- "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)"

