#ifndef __ASM_BASE_H
#define __ASM_BASE_H

#if ASM_FILE

#define EXT_C(x)	x
#define ENTRY(x)	.global EXT_C(x); EXT_C(x):

#endif

#endif