#!/usr/bin/env bash

mplayer -ao null out.ogv -vo jpeg:outdir=output
convert output/* output.gif
nautilus .
convert output.gif -fuzz 10% -layers Optimize optimised.gif

