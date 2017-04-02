function matrix = normspectrogram(t, acc)
% NORMSPECTROGRAM(T, ACC) 
%   t: Time array
%   acc: Acceleration array
%
% This function create a normalized spectrogram matrix by doing the following
% algorithm:
%
%   Each spectrum is divided on 5-second windows overlapped by 2.5 seconds
%   (50%), on each window is applied:
%   1. Baseline correction
%   2. Tuckey window is applied with r=5%.
%   3. FFT on window signal.
%   4. Spectrum is smoothed by 5 points halfwidth moving average.
%   5. Each element of spectrum is normalized by maximum epsectral amplitude.
%
% Author: Pablo Pizarro @ppizarror.com, 2017.
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.



end
