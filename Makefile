TEMPFILES := $(shell find .                \
		-type d -name node_modules \
		-o -name bundle.js         \
		-o -name \*.map            \
		-o -name .log)

all:
	@

clean:
	$(RM) -r ${TEMPFILES}
