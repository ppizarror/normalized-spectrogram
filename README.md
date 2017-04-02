# Normalized spectrogram
Normalized spectrogram to seismic acceleration written in *Matlab*. The algorithm used is the following:

> 1. Baseline correction
2. Tuckey window is applied with r=5%.
3. FFT on window signal.
4. Spectrum is smoothed by 5 points halfwidth moving average.
5. Each element of spectrum is normalized by maximum epsectral amplitude.


## Usage

## Licence
This project is licenced under GPLv2 (GNU General Public License, version 2) [https://www.gnu.org/licenses/gpl-2.0.html].

## Author
Author: Pablo Pizarro, 2017.<br>
Acknowledgments to Felipe Ochoa.