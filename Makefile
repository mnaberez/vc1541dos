START=0xa000
NAME=vc1541dos80-$(START)

all: clean $(NAME).bin diff

# compare the assembled binary against the original binary
# "UD11_1541_80_A000_2532.bin" dumped by Sven Petersen
diff: $(NAME).bin
ifeq ($(START),0xa000)
	echo "2aa1a294acab0684457033e407e2adf1816c2d84" > original.sha1
	openssl sha1 $(NAME).bin | cut -d ' ' -f 2 > $(NAME).sha1
	diff original.sha1 $(NAME).sha1
else
	$(info Diff against original binary skipped.)
endif

# show the assembler listing file
list: $(NAME).bin
	cat $(NAME).lst

# assemble the source to a 4K binary
$(NAME).bin:
	cp -f vc1541dos80.asm $(NAME).asm
	as6500 -l -p -w -o $(NAME).asm
	rm -f $(NAME).asm
	aslink $(NAME) -b vc1541dos=$(START) -i -u
	mv $(NAME).rst $(NAME).lst
	srec_cat $(NAME).ihx -intel -offset -$(START) -fill 0xff 0 4096 -o $(NAME).bin -binary

clean:
	rm -f *.bin *.hlr *.ihx *.lst *.rel *.rst *.sha1
