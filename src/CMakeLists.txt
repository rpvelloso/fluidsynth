# FluidSynth - A Software Synthesizer
#
# Copyright (C) 2003-2010 Peter Hanappe and others.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# as published by the Free Software Foundation; either version 2.1 of
# the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
# 02111-1307, USA

# CMake based build system. Pedro Lopez-Cabanillas <plcl@users.sf.net>

include_directories (
    ${CMAKE_BINARY_DIR}
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/src/synth
    ${CMAKE_SOURCE_DIR}/src/midi
    ${CMAKE_SOURCE_DIR}/src/sfloader
    ${CMAKE_SOURCE_DIR}/src/utils
    ${CMAKE_SOURCE_DIR}/src/rvoice
    ${CMAKE_SOURCE_DIR}/include
    ${CMAKE_BINARY_DIR}/include
    ${PTHREADS_INCLUDE_DIR}
)

include_directories (
    SYSTEM
    ${GLIB_INCLUDEDIR}
    ${GLIB_INCLUDE_DIRS}
)

# ************ library ************

set ( config_SOURCES ${CMAKE_BINARY_DIR}/config.h )

set ( libfluidsynth_SOURCES
    utils/fluid_conv.c
    utils/fluid_conv.h
    utils/fluid_hash.c
    utils/fluid_hash.h
    utils/fluid_list.c
    utils/fluid_list.h
    utils/fluid_ringbuffer.c
    utils/fluid_ringbuffer.h
    utils/fluid_settings.c
    utils/fluid_settings.h
    utils/fluidsynth_priv.h
    utils/fluid_sys.c
    utils/fluid_sys.h
    sfloader/fluid_defsfont.c
    sfloader/fluid_defsfont.h
    sfloader/fluid_sfont.h
    sfloader/fluid_sfont.c
    sfloader/fluid_sffile.c
    sfloader/fluid_sffile.h
    sfloader/fluid_samplecache.c
    sfloader/fluid_samplecache.h
    rvoice/fluid_adsr_env.c
    rvoice/fluid_adsr_env.h
    rvoice/fluid_chorus.c
    rvoice/fluid_chorus.h
    rvoice/fluid_iir_filter.c
    rvoice/fluid_iir_filter.h
    rvoice/fluid_lfo.c
    rvoice/fluid_lfo.h
    rvoice/fluid_rvoice.h
    rvoice/fluid_rvoice.c
    rvoice/fluid_rvoice_dsp.c
    rvoice/fluid_rvoice_event.h
    rvoice/fluid_rvoice_event.c
    rvoice/fluid_rvoice_mixer.h
    rvoice/fluid_rvoice_mixer.c
    rvoice/fluid_phase.h
    rvoice/fluid_rev.c
    rvoice/fluid_rev.h
    synth/fluid_chan.c
    synth/fluid_chan.h
    synth/fluid_event.c
    synth/fluid_event.h
    synth/fluid_gen.c
    synth/fluid_gen.h
    synth/fluid_mod.c
    synth/fluid_mod.h
    synth/fluid_synth.c
    synth/fluid_synth.h
    synth/fluid_synth_monopoly.c
    synth/fluid_tuning.c
    synth/fluid_tuning.h
    synth/fluid_voice.c
    synth/fluid_voice.h
    midi/fluid_midi.c
    midi/fluid_midi.h
    midi/fluid_midi_router.c
    midi/fluid_midi_router.h
    midi/fluid_seqbind.c
    midi/fluid_seq.c
)

set ( public_HEADERS
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/event.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/gen.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/log.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/midi.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/misc.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/mod.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/seq.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/seqbind.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/settings.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/sfont.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/synth.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/types.h
    ${CMAKE_SOURCE_DIR}/include/fluidsynth/voice.h
    ${CMAKE_BINARY_DIR}/include/fluidsynth/version.h
)

set ( public_main_HEADER
    ${CMAKE_BINARY_DIR}/include/fluidsynth.h
)

configure_file ( ${CMAKE_SOURCE_DIR}/include/fluidsynth/version.h.in 
                 ${CMAKE_BINARY_DIR}/include/fluidsynth/version.h )
configure_file ( ${CMAKE_SOURCE_DIR}/include/fluidsynth.cmake
                 ${public_main_HEADER} )

if ( WIN32 AND NOT MINGW )
include(generate_product_version)
generate_product_version(
    VersionFilesOutputVariable
    NAME "Fluidsynth"
    BUNDLE "Fluidsynth"
    VERSION_MAJOR ${FLUIDSYNTH_VERSION_MAJOR}
    VERSION_MINOR ${FLUIDSYNTH_VERSION_MINOR}
    VERSION_PATCH ${FLUIDSYNTH_VERSION_MICRO}
    VERSION_REVISION 0
    COMMENTS "Fluidsynth"
    COMPANY_NAME "Fluidsynth LGPL"
    ORIGINAL_FILENAME "libfluidsynth.dll"
    FILE_DESCRIPTION "Fluidsynth"
)
endif ( WIN32 AND NOT MINGW )

link_directories (
    ${GLIB_LIBDIR}
    ${GLIB_LIBRARY_DIRS}
)


# note: by default this target creates a shared object (or dll). To build a
# static library instead, set the option BUILD_SHARED_LIBS to FALSE.
add_library ( libfluidsynth
    ${config_SOURCES}
    ${libfluidsynth_SOURCES}
    ${public_HEADERS}
    ${public_main_HEADER}
    ${VersionFilesOutputVariable}
)

if ( MACOSX_FRAMEWORK )
     set_property ( SOURCE ${public_HEADERS}
         PROPERTY MACOSX_PACKAGE_LOCATION Headers/fluidsynth
     )
    set_target_properties ( libfluidsynth
      PROPERTIES
        OUTPUT_NAME "FluidSynth"
        FRAMEWORK TRUE
        PUBLIC_HEADER "${public_main_HEADER}"
        FRAMEWORK_VERSION "${LIB_VERSION_CURRENT}"
        INSTALL_NAME_DIR ""
        VERSION ${LIB_VERSION_INFO}
        SOVERSION ${LIB_VERSION_CURRENT}
    )
elseif ( OS2 )
    set_target_properties ( libfluidsynth
      PROPERTIES
        PUBLIC_HEADER "${public_HEADERS}"
        OUTPUT_NAME "fluidsynth"
        VERSION ${LIB_VERSION_INFO}
        SOVERSION ${LIB_VERSION_CURRENT}
    )
elseif ( WIN32 )
  set_target_properties ( libfluidsynth
    PROPERTIES
      PUBLIC_HEADER "${public_HEADERS}"
      ARCHIVE_OUTPUT_NAME "fluidsynth"
      PREFIX "lib"
      OUTPUT_NAME "fluidsynth-${LIB_VERSION_CURRENT}"
      VERSION ${LIB_VERSION_INFO}
      SOVERSION ${LIB_VERSION_CURRENT}
    )
else ( MACOSX_FRAMEWORK )
  set_target_properties ( libfluidsynth
    PROPERTIES
      PUBLIC_HEADER "${public_HEADERS}"
      PREFIX "lib"
      OUTPUT_NAME "fluidsynth"
      VERSION ${LIB_VERSION_INFO}
      SOVERSION ${LIB_VERSION_CURRENT}
  )
endif ( MACOSX_FRAMEWORK )

if ( LIBFLUID_CPPFLAGS )
  set_target_properties ( libfluidsynth
    PROPERTIES COMPILE_FLAGS ${LIBFLUID_CPPFLAGS} )
endif ( LIBFLUID_CPPFLAGS )

target_link_libraries ( libfluidsynth
    ${GLIB_LIBRARIES}
    ${GMODULE_LIBRARIES}
    ${LIBFLUID_LIBS}
)
