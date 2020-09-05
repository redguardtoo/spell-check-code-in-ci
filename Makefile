# -*- Makefile -*-
SHELL = /bin/sh
EMACS ?= emacs

clean:
	@rm -f *~
	@rm -f \#*\#
	@rm -rf deps/
	@rm -f *.elc

.PHONY: deps

deps:
	@mkdir -p deps;
	@if [ ! -f deps/wucuo.el ]; then curl -L https://raw.githubusercontent.com/redguardtoo/wucuo/master/wucuo.el > deps/wucuo.el; fi;
	@if [ ! -f deps/wucuo-sdk.el ]; then curl -L https://raw.githubusercontent.com/redguardtoo/wucuo/master/wucuo-sdk.el > deps/wucuo-sdk.el; fi;
	@if [ ! -f deps/wucuo-flyspell-html-verify.el ]; then curl -L https://raw.githubusercontent.com/redguardtoo/wucuo/master/wucuo-flyspell-html-verify.el > deps/wucuo-flyspell-html-verify.el; fi;
	@if [ ! -f deps/wucuo-flyspell-org-verify.el ]; then curl -L https://raw.githubusercontent.com/redguardtoo/wucuo/master/wucuo-flyspell-org-verify.el > deps/wucuo-flyspell-org-verify.el; fi;

test: deps
	@$(EMACS) -batch -Q -L deps/ -l deps/wucuo.el --eval '(let* ((ispell-program-name "aspell") (ispell-extra-args (wucuo-aspell-cli-args t))) (wucuo-spell-check-file "src/main.js" t))'
