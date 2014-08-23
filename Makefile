PROGRAM = using-git
PKGNAME = using-git
TEXINFO_DIR = .

PREFIX = /usr
DATA = /share

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
info: $(PROGRAM).info
pdf: $(PROGRAM).pdf
ps: $(PROGRAM).ps
dvi: $(PROGRAM).dvi

#logo.pdf: logo.svg
#        rsvg-convert --format=pdf "$<" > "$@"

#logo.eps: obj/logo.ps
#        ps2eps "$<"

#logo.ps: logo.svg
#        rsvg-convert --format=ps "$<" > "$@"

%.info: $(TEXINFO_DIR)/%.texinfo
	$(MAKEINFO) $(TEXIFLAGS) "$<"

%.pdf: $(TEXINFO_DIR)/%.texinfo
	texi2pdf $(TEXIFLAGS) "$<"

%.dvi: $(TEXINFO_DIR)/%.texinfo
	$(TEXI2DVI) $(TEXIFLAGS) "$<"

%.ps: $(TEXINFO_DIR)/%.texinfo
	texi2pdf $(TEXIFLAGS) --ps "$<"

.PHONY: install-info
install: install-info
install-info: $(PROGRAM).info.gz
	install -Dm644 "$<" -- "$(DESTDIR)$(PREFIX)$(DATA)/info/$(PKGNAME).info.gz"

.PHONY: uninstall-info
uninstall: uninstall-info
uninstall-info:
	-rm -- "$(DESTDIR)$(PREFIX)$(DATA)/info/$(PKGNAME).info.gz"

.PHONY: clean-texinfo
clean: clean-texinfo
clean-texinfo:
	-rm -- *.{info,pdf,ps,dvi}
	-rm -- *.{aux,cp,cps,fn,ky,log,pg,pgs,toc,tp,vr,vrs}

## License section

.PHONY: install-license
install: install-license
install-license:
	install -d -- "$(DESTDIR)$(PREFIX)$(DATA)/licenses/$(PKGNAME)"
	install -m644 LICENSE -- "$(DESTDIR)$(PREFIX)$(DATA)/licenses/$(PKGNAME)"

.PHONY: uninstall-license
uninstall: uninstall-license
uninstall-license:
	-rm -- "$(DESTDIR)$(PREFIX)$(DATA)/licenses/$(PKGNAME)/LICENSE"
	-rmdir -- "$(DESTDIR)$(PREFIX)$(DATA)/licenses/$(PKGNAME)"

