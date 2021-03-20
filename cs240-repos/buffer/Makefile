# CS 240 Dark Buffer Arts

EXPLOITS = exploit1.hex exploit2.hex exploit3.hex exploit4.hex 

test: id.txt
	@echo "run -g -u `cat id.txt` < __test.bytes >> __results.log" > __gdb.in
	@echo "quit" >> __gdb.in
	@touch __results.log
	@for e in $(EXPLOITS); do if [ -e $$e ]; then echo $$e >> __results.log; ./hex2raw < $$e > __test.bytes; gdb -x __gdb.in umbrella; echo >> __results.log; fi; done
	@echo
	@echo == Summary ================================
	@cat __results.log
	@rm -f __gdb.in __test.bytes __results.log

id.txt:
	@cs240 id > $@
cookie.txt: id.txt
	@./id2cookie $$(cat $<) > $@
	@git add $@ $<
	@git commit -m "[make cookie]" $@ $<
cookie: id.txt cookie.txt
	@echo "The cookie for $$(cat id.txt) is:"
	@cat cookie.txt
	@echo

.PHONY: cookie
