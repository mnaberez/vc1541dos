all: clean out.bin diff

# compare the assembled binary against the original binary
# "UD11_1541_80_A000_2532.bin" dumped by Sven Petersen
diff: out.bin
	echo "2aa1a294acab0684457033e407e2adf1816c2d84" > original.sha1
	openssl sha1 out.bin | cut -d ' ' -f 2 > out.sha1
	diff original.sha1 out.sha1

# show the assembler listing file
list: out.bin
	cat out.lst

# assemble the source to a 4K binary
out.bin:
	cp -f vc1541dos80.asm out.asm
	as6500 -l -p -w -o out.asm
	rm -f out.asm
	aslink out -i
	srec_cat out.ihx -intel -offset -0xa000 -o out.bin -binary

clean:
	rm -f out.*
	rm -f *.sha1
