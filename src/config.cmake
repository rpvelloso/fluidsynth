#ifndef CONFIG_H
#define CONFIG_H

/* Define if building for Mac OS X Darwin */
#cmakedefine DARWIN @DARWIN@

/* Soundfont to load automatically in some use cases */
#cmakedefine DEFAULT_SOUNDFONT "@DEFAULT_SOUNDFONT@"

/* Define to enable FPE checks */
#cmakedefine FPE_CHECK @FPE_CHECK@

/* Define to 1 if you have the <dlfcn.h> header file. */
#cmakedefine HAVE_DLFCN_H @HAVE_DLFCN_H@

/* Define to 1 if you have the <errno.h> header file. */
#cmakedefine HAVE_ERRNO_H @HAVE_ERRNO_H@

/* Define to 1 if you have the <fcntl.h> header file. */
#cmakedefine HAVE_FCNTL_H @HAVE_FCNTL_H@

/* Define to 1 if you have the <inttypes.h> header file. */
#cmakedefine HAVE_INTTYPES_H @HAVE_INTTYPES_H@

/* Define to 1 if you have the <io.h> header file. */
#cmakedefine HAVE_IO_H @HAVE_IO_H@

/* Define to 1 if you have the `pthread' library (-lpthread). */
#cmakedefine HAVE_LIBPTHREAD @HAVE_LIBPTHREAD@

/* Define to 1 if you have the <limits.h> header file. */
#cmakedefine HAVE_LIMITS_H @HAVE_LIMITS_H@

/* Define to 1 if you have the <machine/soundcard.h> header file. */
#cmakedefine HAVE_MACHINE_SOUNDCARD_H @HAVE_MACHINE_SOUNDCARD_H@

/* Define to 1 if you have the <math.h> header file. */
#cmakedefine HAVE_MATH_H @HAVE_MATH_H@

/* Define to 1 if you have the <memory.h> header file. */
#cmakedefine HAVE_MEMORY_H @HAVE_MEMORY_H@

/* Define if compiling with openMP to enable parallel audio rendering */
#cmakedefine HAVE_OPENMP @HAVE_OPENMP@

/* Define to 1 if you have the <pthread.h> header file. */
#cmakedefine HAVE_PTHREAD_H @HAVE_PTHREAD_H@

/* Define to 1 if you have the <signal.h> header file. */
#cmakedefine HAVE_SIGNAL_H @HAVE_SIGNAL_H@

/* Define to 1 if you have the <stdarg.h> header file. */
#cmakedefine HAVE_STDARG_H @HAVE_STDARG_H@

/* Define to 1 if you have the <stdint.h> header file. */
#cmakedefine HAVE_STDINT_H @HAVE_STDINT_H@

/* Define to 1 if you have the <stdio.h> header file. */
#cmakedefine HAVE_STDIO_H @HAVE_STDIO_H@

/* Define to 1 if you have the <stdlib.h> header file. */
#cmakedefine HAVE_STDLIB_H @HAVE_STDLIB_H@

/* Define to 1 if you have the <strings.h> header file. */
#cmakedefine HAVE_STRINGS_H @HAVE_STRINGS_H@

/* Define to 1 if you have the <string.h> header file. */
#cmakedefine HAVE_STRING_H @HAVE_STRING_H@

/* Define to 1 if you have the <sys/ioctl.h> header file. */
#cmakedefine HAVE_SYS_IOCTL_H @HAVE_SYS_IOCTL_H@

/* Define to 1 if you have the <sys/mman.h> header file. */
#cmakedefine HAVE_SYS_MMAN_H @HAVE_SYS_MMAN_H@

/* Define to 1 if you have the <sys/soundcard.h> header file. */
#cmakedefine HAVE_SYS_SOUNDCARD_H @HAVE_SYS_SOUNDCARD_H@

/* Define to 1 if you have the <sys/stat.h> header file. */
#cmakedefine HAVE_SYS_STAT_H @HAVE_SYS_STAT_H@

/* Define to 1 if you have the <sys/time.h> header file. */
#cmakedefine HAVE_SYS_TIME_H @HAVE_SYS_TIME_H@

/* Define to 1 if you have the <sys/types.h> header file. */
#cmakedefine HAVE_SYS_TYPES_H @HAVE_SYS_TYPES_H@

/* Define to 1 if you have the <unistd.h> header file. */
#cmakedefine HAVE_UNISTD_H @HAVE_UNISTD_H@

/* Define to 1 if you have the <windows.h> header file. */
#cmakedefine HAVE_WINDOWS_H @HAVE_WINDOWS_H@

/* Define to 1 if you have the <getopt.h> header file. */
#cmakedefine HAVE_GETOPT_H @HAVE_GETOPT_H@

/* Define if using the MinGW32 environment */
#cmakedefine MINGW32 @MINGW32@

/* Define to 1 if your C compiler doesn't accept -c and -o together. */
#cmakedefine NO_MINUS_C_MINUS_O @NO_MINUS_C_MINUS_O@

/* Name of package */
#cmakedefine PACKAGE "@PACKAGE@"

/* Define to the address where bug reports for this package should be sent. */
#cmakedefine PACKAGE_BUGREPORT @PACKAGE_BUGREPORT@

/* Define to the full name of this package. */
#cmakedefine PACKAGE_NAME @PACKAGE_NAME@

/* Define to the full name and version of this package. */
#cmakedefine PACKAGE_STRING @PACKAGE_STRING@

/* Define to the one symbol short name of this package. */
#cmakedefine PACKAGE_TARNAME @PACKAGE_TARNAME@

/* Define to the version of this package. */
#cmakedefine PACKAGE_VERSION @PACKAGE_VERSION@

/* Define to 1 if you have the ANSI C header files. */
#cmakedefine STDC_HEADERS @STDC_HEADERS@

/* Define to enable SIGFPE assertions */
#cmakedefine TRAP_ON_FPE @TRAP_ON_FPE@

/* Define to do all DSP in single floating point precision */
#cmakedefine WITH_FLOAT @WITH_FLOAT@

/* Define to profile the DSP code */
#cmakedefine WITH_PROFILING @WITH_PROFILING@

/* Define if the compiler supports VLA */ 
#cmakedefine SUPPORTS_VLA @SUPPORTS_VLA@ 

/* Define to 1 if your processor stores words with the most significant byte
   first (like Motorola and SPARC, unlike Intel and VAX). */
#cmakedefine WORDS_BIGENDIAN @WORDS_BIGENDIAN@

/* Define to `__inline__' or `__inline' if that's what the C compiler
   calls it, or to nothing if 'inline' is not supported under any name.  */
#ifndef __cplusplus
#cmakedefine inline @INLINE_KEYWORD@
#endif

#endif /* CONFIG_H */
