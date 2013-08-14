PROGRAM = using-git
PKGNAME = using-git
TEXINFO_DIR = .

PREFIX = /usr
DATA = /share



.PHONY: all
all:


%.gz: %
	gzip -9c < "$<" > "$@"

%.bz2: %
	bzip2 -9c < "$<" > "$@"

%.xz: %
	xz -e9 < "$<" > "$@"


.PHONY: install
install:

.PHONY: uninstall
uninstall:

.PHONY: clean
clean:
	-rn -r -- bin obj

## Texinfo manual section

.PHONY: doc
all: doc
doc: info

.PHONY: info pdf ps dvi
info: $(PROGRAM).info.gz
pdf: $(PROGRAM).pdf.gz
ps: $(PROGRAM).ps.gz
dvi: $(PROGRAM).dvi.gz

%.info: $(TEXINFO_DIR)/%.texinfo
	$(MAKEINFO) "$<"

%.pdf: $(TEXINFO_DIR)/%.texinfo
	texi2pdf "$<"

%.dvi: $(TEXINFO_DIR)/%.texinfo
	$(TEXI2DVI) "$<"

%.ps: $(TEXINFO_DIR)/%.texinfo
	texi2pdf --ps "$<"

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
	-rm -- *.{info,pdf,ps,dvi}{,.gz,.bz2,.xz}

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

