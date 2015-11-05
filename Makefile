SHELL = /bin/bash

.PHONY: all
all: git_hooks
	$(info make clean:       remove tags, clean up after tests)
	$(info make git_hooks:   set up Git repository hooks)
	$(info make tags:        create tags file)
	$(info make test:        run checks on manifests)

.PHONY: tags
tags: git_hooks
	$(SHELL) tools/mktags

puppet_parseonly = puppet parser validate

.PHONY: clean
clean: git_hooks
	$(RM) -r .pre-commit tags

.PHONY: git_hooks
git_hooks:
	@if ! git config --get remote.origin.push '^HEAD$$' >/dev/null; then \
		git config --add remote.origin.push HEAD; \
	fi
	@if git config --get remote.origin.push '^refs/notes/audit:refs/notes/audit$$' >/dev/null; then \
		git config --unset remote.origin.push refs/notes/audit:refs/notes/audit; \
	fi
	@if git config --get branch.master.rebase true >/dev/null; then \
		git config branch.master.rebase true; \
	fi
	@ln -sf ../../tools/git_hooks/pre-commit .git/hooks/pre-commit
	@ln -sF ../../tools/git_hooks/commit_hooks .git/hooks/commit_hooks
	@$(RM) .git/hooks/post-commit
