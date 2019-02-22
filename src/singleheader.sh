#!/bin/bash

ifheaders=(
	'../build/include/fluidsynth.h'
	'../include/fluidsynth/types.h'
	'../include/fluidsynth/settings.h'
	'../include/fluidsynth/synth.h'
	'../include/fluidsynth/sfont.h'
	'../include/fluidsynth/event.h'
	'../include/fluidsynth/midi.h'
	'../include/fluidsynth/seq.h'
	'../include/fluidsynth/seqbind.h'
	'../include/fluidsynth/log.h'
	'../include/fluidsynth/misc.h'
	'../include/fluidsynth/mod.h'
	'../include/fluidsynth/gen.h'
	'../include/fluidsynth/voice.h'
	'../build/include/fluidsynth/version.h'
)

headers=(
	'./rvoice/fluid_phase.h'
	'./utils/fluid_glib_remover.h'
	'./utils/fluidsynth_priv.h'
	'./rvoice/fluid_iir_filter.h'
	'./synth/fluid_gen.h'
	'./utils/fluid_conv.h'
	'./synth/fluid_mod.h'
	'./utils/fluid_sys.h'
	'./rvoice/fluid_lfo.h'
	'./rvoice/fluid_adsr_env.h'
	'./utils/fluid_settings.h'
	'./utils/fluid_ringbuffer.h'
	'./utils/fluid_list.h'
	'./utils/fluid_hash.h'
	'./synth/fluid_tuning.h'
	'./rvoice/fluid_rev.h'
	'./rvoice/fluid_chorus.h'
	'./synth/fluid_event.h'
	'./midi/fluid_midi.h'
	'./midi/fluid_midi_router.h'
	'./sfloader/fluid_sfont.h'
	'./rvoice/fluid_rvoice.h'
	'./rvoice/fluid_rvoice_mixer.h'
	'./rvoice/fluid_rvoice_event.h'
	'./synth/fluid_voice.h'
	'./synth/fluid_synth.h'
	'./sfloader/fluid_sffile.h'
	'./sfloader/fluid_defsfont.h'
	'./sfloader/fluid_samplecache.h'
	'./synth/fluid_chan.h'
)

sources=(
	'./midi/fluid_midi.c'
	'./midi/fluid_midi_router.c'
	'./midi/fluid_seq.c'
	'./midi/fluid_seqbind.c'
	'./rvoice/fluid_adsr_env.c'
	'./rvoice/fluid_chorus.c'
	'./rvoice/fluid_iir_filter.c'
	'./rvoice/fluid_lfo.c'
	'./rvoice/fluid_rev.c'
	'./rvoice/fluid_rvoice.c'
	'./rvoice/fluid_rvoice_dsp.c'
	'./rvoice/fluid_rvoice_event.c'
	'./rvoice/fluid_rvoice_mixer.c'
	'./sfloader/fluid_defsfont.c'
	'./sfloader/fluid_samplecache.c'
	'./sfloader/fluid_sffile.c'
	'./sfloader/fluid_sfont.c'
	'./synth/fluid_chan.c'
	'./synth/fluid_event.c'
	'./synth/fluid_gen.c'
	'./synth/fluid_mod.c'
	'./synth/fluid_synth.c'
	'./synth/fluid_synth_monopoly.c'
	'./synth/fluid_tuning.c'
	'./synth/fluid_voice.c'
	'./utils/fluid_conv.c'
	'./utils/fluid_hash.c'
	'./utils/fluid_list.c'
	'./utils/fluid_ringbuffer.c'
	'./utils/fluid_settings.c'
	'./utils/fluid_sys.c'
)

rm -rf fs.h fs.c

echo '#define HAVE_STDINT_H 1' >> fs.c
echo '#define FLUIDSYNTH_NOT_A_DLL' >> fs.c
echo '#define SUPPORTS_VLA' >> fs.c


i=0
while [ "${ifheaders[i]}" != "" ]
do
   cat ${ifheaders[i]}|egrep -v '#include \"' >> fs.c
   cat ${ifheaders[i]}|egrep -v '#include \"' >> fs.h
   i=$(( $i + 1 ))
done

i=0
while [ "${headers[i]}" != "" ]
do
   cat ${headers[i]}|egrep '(#include <)'|egrep -v '(#include <glib.h>|#include <sys/mman.h>|#include <sys/socket.h>|#include <netinet/in.h>|#include <netinet/tcp.h>|#include <arpa/inet.h>|#include <gmodule.h>|#include <glib/gstdio.h>|#include <os2.h>|#include <sys/select.h>)' >> fs.c
   i=$(( $i + 1 ))
done

i=0
while [ "${headers[i]}" != "" ]
do
   cat ${headers[i]}|egrep -v '#include \"' >> fs.c
   i=$(( $i + 1 ))
done

i=0
while [ "${sources[i]}" != "" ]
do
   cat ${sources[i]}|egrep -v '#include "' >> fs.c
   i=$(( $i + 1 ))
done
