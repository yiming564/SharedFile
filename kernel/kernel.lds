OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
OUTPUT_ARCH(i386:x86-64)
ENTRY(init32)

PHDRS
{
	entry		PT_LOAD		FLAGS(5);
	multiboot2	PT_LOAD		FLAGS(4);
	text		PT_LOAD		FLAGS(5);
	rodata		PT_LOAD		FLAGS(4);
	data		PT_LOAD		FLAGS(6);
	comment		PT_LOAD		FLAGS(4);
	dynamic		PT_DYNAMIC	FLAGS(4);
	note		PT_NOTE		FLAGS(4);
}

SECTIONS 
{
	. = 1M;
	.entry :
	{
		init32 = .;
		*(.entry)
	} : entry
	.multiboot2 : ALIGN(4K)
	{
		*(.multiboot2)
	} : multiboot2
	. = 16M;
	.text :
	{
		kmain = .;
		*(.text)
	} : text
	.rodata :
	{
		*(.rodata)
	} : rodata
	.data :
	{
		*(.data)
	} : data
	.bss :
	{
		kstack = .;
		*(.bss)
	} : data
	. += 8M;
	.comment :
	{
		*(.comment)
	} : comment
	.dynamic :
	{
		*(.dynamic)
	} : dynamic
	.dynstr :
	{
		*(.dynstr)
	}
	.symtab :
	{
		*(.symtab)
	} : note
	.strtab :
	{
		*(.strtab)
	} : note
	.shstrtab :
	{
		*(.shstrtab)
	} : note
	.note.gnu.build-id :
	{
		*(.note.gnu.build-id)
	} : note
	.gnu.hash :
	{
		*(.gnu.hash)
	} : note
}