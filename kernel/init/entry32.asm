%include "multiboot2.inc"
	
section .multiboot2 align=8
multiboot2_header:
	align 8
    dd MULTIBOOT2_HEADER_MAGIC
    dd MULTIBOOT_ARCHITECTURE_I386
    dd multiboot2_header_end - multiboot2_header
    dd - (MULTIBOOT2_HEADER_MAGIC + multiboot2_header_end - multiboot2_header)
	align 8
	bootinfo_request_tag:
        dd MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST
        dd bootinfo_request_tag_end - bootinfo_request_tag
        dd MULTIBOOT_TAG_TYPE_MMAP    ; memory map
        dd MULTIBOOT_TAG_TYPE_FRAMEBUFFER    ; framebuffer info
    bootinfo_request_tag_end:
	align 8
	framebuffer_tag:
        dd MULTIBOOT_HEADER_TAG_FRAMEBUFFER
        dd framebuffer_tag_end - framebuffer_tag
        dd 1920 ; width
        dd 1080 ; height
        dd 32   ; depth
    framebuffer_tag_end:
	align 8
    end_tag_start:
	dw MULTIBOOT_HEADER_TAG_END
    dw 0
    dd end_tag_end - end_tag_start
	end_tag_end:
multiboot2_header_end:

section .entry
init32:
	cmp eax, MULTIBOOT2_BOOTLOADER_MAGIC
	jne bad_bootloader

	jmp $

bad_bootloader:
	mov eax, 0
    hlt
	jmp bad_bootloader