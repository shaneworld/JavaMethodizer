TESTS_INIT=tests/minimal_init.lua
TESTS_DIR=tests/

.PHONY: test
test:
	@nvim \
		--headless \
		--noplugin \
		-u ${TESTS_INIT} \
		-c "PlenaryBustedDirectory ${TESTS_DIR} { minimal_init = '${TESTS_INIT}' }"

.PHONY: install-deps
install-deps:
	@mkdir -p .deps
	@git clone --depth 1 https://github.com/nvim-lua/plenary.nvim.git .deps/plenary.nvim

.PHONY: clean
clean:
	@rm -rf .deps
