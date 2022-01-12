# Requirements:
#  - ASXXXX (https://shop-pdp.net/ashtml/asxxxx.php)
#  - SRecord (http://srecord.sourceforge.net/)
#  - OpenSSL (https://www.openssl.org/)

# VC-1541-DOS was originally for 0xA000 (socket UD11)
# but a different start address can be specified here
START=0xa000
NAME=vc1541dos80-$(START)

# default build target
all: $(NAME).bin

# assemble the source to a 4K binary
$(NAME).bin: vc1541dos80.asm
	cp -f vc1541dos80.asm $(NAME).asm
	as6500 -l -p -w -o $(NAME).asm
	rm -f $(NAME).asm
	aslink -b vc1541dos=$(START) -i -u $(NAME)
	mv $(NAME).rst $(NAME).lst
	srec_cat $(NAME).ihx -intel -offset -$(START) -fill 0xff 0 4096 -o $(NAME).bin -binary

# show the assembler listing file
list: $(NAME).bin
	cat $(NAME).lst

# compare the assembled binary against the original binary
# "UD11_1541_80_A000_2532.bin" dumped by Sven Petersen
diff: $(NAME).bin
	echo "2aa1a294acab0684457033e407e2adf1816c2d84" > original.sha1
	openssl sha1 $(NAME).bin | cut -d ' ' -f 2 > $(NAME).sha1
	diff original.sha1 $(NAME).sha1

# remove all build artifacts
clean:
	rm -f *.bin *.hlr *.ihx *.lst *.rel *.rst *.sha1
