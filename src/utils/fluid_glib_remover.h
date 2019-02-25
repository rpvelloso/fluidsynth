/*
 * fluid_glib_remover.h
 *
 *  Created on: 10 de ago de 2018
 *      Author: rvelloso
 */

#ifndef SRC_UTILS_FLUID_GLIB_REMOVER_H_
#define SRC_UTILS_FLUID_GLIB_REMOVER_H_

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <stdint.h>

#define TRUE 1
#define FALSE 0
#define G_LITTLE_ENDIAN 1234
#define G_BIG_ENDIAN    4321
#define G_BYTE_ORDER G_LITTLE_ENDIAN

typedef pthread_mutex_t GStaticMutex;
typedef pthread_mutex_t GStaticRecMutex;
typedef pthread_mutex_t GMutex;
typedef pthread_cond_t GCond;
typedef pthread_key_t GStaticPrivate;
typedef pthread_t GThread;
typedef void * gpointer;
typedef size_t gsize;
typedef unsigned int guint;
typedef unsigned long gulong;
typedef long glong;
typedef struct timeval GTimeVal;
typedef void *(*GThreadFunc)(void *);
typedef char gchar;
typedef int gint;
typedef uint32_t guint32;
typedef int gboolean;

typedef guint32 GQuark;

typedef struct GError {
  GQuark       domain;
  gint         code;
  gchar       *message;
} GError;

#define G_UNLIKELY(expr) (expr)
#define G_LIKELY(expr) (expr)

#define GSIZE_TO_POINTER(s) ((gpointer) (gsize) (s))
#define GPOINTER_TO_UINT(p) ((guint) (gulong) (p))
#define GPOINTER_TO_INT(p) ((gint) (glong) (p))
#define GINT_TO_POINTER(i) ((gpointer) (glong) (i))
#define GINT32_FROM_LE(val) (val)
#define GINT16_FROM_LE(val) (val)

#define g_thread_init(p) do {} while (0)
#define g_return_val_if_fail(x, v) do {} while (0)

#define g_vsnprintf vsnprintf
#define g_get_current_time(t) gettimeofday(t, NULL)
#define g_usleep usleep

static inline GThread *
g_thread_create(
		GThreadFunc func,
        gpointer data,
        gboolean joinable,
        GError **error) {
	pthread_t t;

	if (pthread_create(&t, NULL, func, data) != 0)
		return NULL;

	if (!joinable)
		pthread_detach(t);

	pthread_t *ret = (pthread_t *)malloc(sizeof(pthread_t));
	*ret = t;
	return ret;
}

#define G_STATIC_MUTEX_INIT PTHREAD_MUTEX_INITIALIZER
#define g_static_mutex_free pthread_mutex_destroy
#define g_static_mutex_lock pthread_mutex_lock
#define g_static_mutex_unlock pthread_mutex_unlock

#define g_thread_supported() (1)

#define g_static_mutex_init(m) pthread_mutex_init(m, NULL)

#define g_static_rec_mutex_free pthread_mutex_destroy
#define g_static_rec_mutex_lock pthread_mutex_lock
#define g_static_rec_mutex_unlock pthread_mutex_unlock

#define g_static_rec_mutex_init(m) do {\
	pthread_mutexattr_t Attr;\
	pthread_mutexattr_init(&Attr);\
	pthread_mutexattr_settype(&Attr, PTHREAD_MUTEX_RECURSIVE);\
	pthread_mutex_init(m, &Attr);\
} while (0)

#define g_mutex_free(m) do {\
		pthread_mutex_destroy(m);\
		free(m);\
} while (0)

#define g_mutex_lock pthread_mutex_lock
#define g_mutex_unlock pthread_mutex_unlock

static inline GMutex *
g_mutex_new(void) {
	GMutex *m = malloc(sizeof(GMutex));
	pthread_mutex_init(m, NULL);
	return m;
}

#define g_cond_signal pthread_cond_signal
#define g_cond_broadcast pthread_cond_broadcast
#define g_cond_wait pthread_cond_wait

static inline GMutex *
g_cond_new() {
	GCond *c = malloc(sizeof(GCond));
	pthread_cond_init(c, NULL);
	return c;
}

#define g_cond_free(c) do {\
		pthread_cond_destroy(c);\
		free(c);\
} while (0)

#define g_clear_error(err) do {\
	if (err != NULL) *err = NULL;\
} while (0)


#define g_static_private_init(p) pthread_key_create(p, NULL)
#define g_static_private_get(p) pthread_getspecific(*p)
#define g_static_private_set(p, d, n) pthread_setspecific(*p, d)
#define g_static_private_free(p) pthread_key_delete(*p)

#define g_atomic_int_inc(v) __sync_add_and_fetch(v, 1)
#define g_atomic_int_get(v) __sync_add_and_fetch(v, 0)
#define g_atomic_int_set(v, vv) __sync_val_compare_and_swap(v, *v, vv)
#define g_atomic_int_dec_and_test(v) (__sync_sub_and_fetch(v, 1) == 0)
#define g_atomic_int_compare_and_exchange(v, o, n) __sync_bool_compare_and_swap(v, o, n)
#define g_atomic_int_exchange_and_add(v, vv) __sync_fetch_and_add(v, vv)
#define g_atomic_pointer_get g_atomic_int_get
#define g_atomic_pointer_set g_atomic_int_set
#define g_atomic_pointer_compare_and_exchange g_atomic_int_compare_and_exchange

static inline gpointer
g_thread_join(GThread *t) {
	if (t != NULL) {
		gpointer ret;
		pthread_join(*t, &ret);
		free(t);
		return ret;
	}
	return NULL;
}

#endif /* SRC_UTILS_FLUID_GLIB_REMOVER_H_ */
