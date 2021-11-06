all: clean out.bin diff

diff: out.bin
	diff UD11_1541_80_A000_2532.bin out.bin

out.bin:
	cp -f vc1541dos80.asm out.asm
	as740 -l -o out.asm
	rm -f out.asm
	aslink out -i
	srec_cat out.ihx -intel -offset -0xa000 -o out.bin -binary

clean:
	rm -f out.*
