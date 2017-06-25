# Normalized spectrogram
Normalized spectrogram to seismic acceleration written in *Matlab*. The algorithm used is the following:

```
1. Baseline correction
2. Tuckey window is applied with r=5%.
3. FFT on window signal.
4. Spectrum is smoothed by 5 points halfwidth moving average.
5. Each element of spectrum is normalized by maximum epsectral amplitude.
```

## The function

The normalized spectrogram function is defined by:

```matlab
[matrix, matrix_t, matrix_f] = norm_spectrogram(t, acc)
```

Where:

| Variable | Description |
| :-: | :--|
| t | Time of the seismic accelerogram |
| acc | Acceleration (g) of the seismic accelerogram |

This function returns a **matrix** in where columns refer to mean window time (**matrix_t**), rows are the frequency of the spectrogram (**matrix_f**) and the value of the matrix are the amplitude of the spectrogram from each time-window on each frequency.

To print matrix you should use:

```matlab
[matrix, matrix_t, matrix_f] = plot_norm_matrix(m, mt, mf, t, acc, regname)
```

Where:

| Variable | Description |
| :-: | :--|
|  m |  	 Normalized matrix |
|   mt|     Time array from matrix|
|   mf|      Frequency array from matrix|
|   t|      Time of the seismic data|
|   acc|    Acceleration of seismic data|
|   regname|Name of the seismic data (plot title)|

## Example

Lets suppose that a seismic registry is stored on *data/CNV_APED_201604162359_N_100.txt*, the file structure is like:

```
0.000000	-6.329500
0.010000	2.539600
0.020000	12.822900
0.030000	9.435300
0.040000	-5.397100
0.050000	-14.233900
...
```

Then:

```matlab
% Load the data
data = load('data/CNV_APED_201604162359_N_100.txt');

% Set time and acceleration array
t = data(:, 1);
acc = data(:, 2) ./ 980; % Convert from cm/s2 to g
```

After that we will use ```norm_spectrogram``` function

```matlab
[m, mt, mf] = norm_spectrogram(t, acc);
```

Then plot:

```matlab
plot_norm_matrix(m, mt, mf, t, acc, 'APED 2016/04/16 23:59 N-S');
```

Obtaining:

<p align="center">
<img src="https://raw.githubusercontent.com/ppizarror/ppizarror.github.io/master/resources/images/normalized-spectrogram/figure.png" width="50%px" height="50%px">
</p>

## License
This project is licensed under GPLv2 (GNU General Public License, version 2) [https://www.gnu.org/licenses/gpl-2.0.html].

## Author
Author: Pablo Pizarro, 2017.<br>
Acknowledgments to Felipe Ochoa.