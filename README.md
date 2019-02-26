
# Single Header Stripped off version of FluidSynth

Only synth and sound font functionality were kept.

## What was removed:

- networking;
- audio drivers;
- bindings;
- command line program;
- tests;
- documentation;
- Glib dependency (header fluid_glib_remover.h).

## What was kept:
- synth;
- player;
- SF loader.
	
## The single header library:

- header: [fs.h](https://github.com/rpvelloso/fluidsynth/blob/master/src/fs.h);
- source: [fs.c](https://github.com/rpvelloso/fluidsynth/blob/master/src/fs.c).
	
## Usage:

- Compile the source C file fs.c (e.g., gcc -c fs.c -o fs.o) and;
- Include the header fs.h in your code;
- Link your software with fs.o.
	
## Example (converts MIDI to 16 bit stereo PCM):

```cpp
/* 
compile with: 
	gcc -c fs.c -o fs.o 
	gcc -c test.c -o test.o 
	gcc fs.o test.o -o test 

run:
	./test
	
*/
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "fs.h"

#define SAMPLE_RATE 44100
#define CHANNELS 2
#define BITS_PER_SAMPLE 16
#define BYTES_PER_SAMPLE (BITS_PER_SAMPLE>>3)
#define FRAME_SIZE (BYTES_PER_SAMPLE*CHANNELS)

#define SF_FILE "mysoundfont.sf2"
#define BUF_LEN (FRAME_SIZE * 4 * 1024) // 4k frames
#define FILENAME "mymidifile.mid"
#define OUTFILE "output.wav"

void loadMidiFile(const char *filename, void **buf, size_t *len) {
	FILE *midiFile = fopen(filename, "rb");
	
	if (midiFile != NULL) {
		fseek(midiFile, 0, SEEK_END);
		*len = ftell(midiFile);
		*buf = malloc(*len);
		if (*buf != NULL) {
			rewind(midiFile);
			fread(*buf, *len, 1, midiFile);
		}
		fclose(midiFile);
	}
}

typedef struct WaveHeader {
	char RIFF[4];
	uint32_t chunkSize;
	char WAVE[4];
	char fmt[4];
	uint32_t subChunkSize;

	uint16_t audioFormat;
	uint16_t numChannels;
	uint32_t sampleRate;
	uint32_t byteRate;
	uint16_t blockAlign;
	uint16_t bitsPerSample;

	char data[4];
	uint32_t dataSize;
} WaveHeader;

int main() {
	void *inputBuffer; // midi file loaded in memory
	size_t inputBufferSize;

	loadMidiFile(FILENAME, &inputBuffer, &inputBufferSize);

	if (inputBuffer != NULL && fluid_is_soundfont(SF_FILE)) {
		fluid_settings_t *settings = new_fluid_settings();
		fluid_synth_t *synth = new_fluid_synth(settings);
		fluid_player_t *player = new_fluid_player(synth);
		fluid_synth_sfload(synth, SF_FILE, 1);
		fluid_player_add_mem(player, inputBuffer, inputBufferSize);
		fluid_player_play(player);

		WaveHeader waveHeader = {
			{'R','I','F', 'F'}, 
			0, 
			{'W', 'A', 'V', 'E'}, 
			{'f', 'm', 't', ' '}, 
			0x10, 1, 
			CHANNELS, 
			SAMPLE_RATE, 
			FRAME_SIZE*SAMPLE_RATE, 
			FRAME_SIZE, 
			BITS_PER_SAMPLE, 
			{'d', 'a', 't', 'a'}, 0};

		FILE *out = fopen(OUTFILE, "wb");
		fwrite(&waveHeader, sizeof(waveHeader), 1, out);
		
		void *buf = malloc(BUF_LEN);
		
		while (fluid_player_get_status(player) != FLUID_PLAYER_DONE) {
			fluid_synth_write_s16(
				synth,
				BUF_LEN >> 2, // 16 bit Stereo
				buf, 0, 2,
				buf, 1, 2);
			fwrite(buf, BUF_LEN, 1, out);
			waveHeader.dataSize += BUF_LEN;
		}
		
		free(buf);
		
		delete_fluid_player(player);
		delete_fluid_synth(synth);
		delete_fluid_settings(settings);
		
		free(inputBuffer);
		
		rewind(out);
		waveHeader.chunkSize = waveHeader.dataSize + 36;
		fwrite(&waveHeader, sizeof(waveHeader), 1, out);
		fclose(out);
	}
}
```
