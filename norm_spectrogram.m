function [matrix, varargout] = norm_spectrogram(t, acc)
% NORMSPECTROGRAM This function create a normalized spectrogram matrix by
% doing the following algorithm:
%
%   Each spectrum is divided on 5-second windows overlapped by 2.5 seconds
%   (50%), on each window is applied:
%       1. Baseline correction
%       2. Tuckey window is applied with r=5%.
%       3. FFT on window signal.
%       4. Spectrum is smoothed by 5 points halfwidth moving average.
%       5. Each element of spectrum is normalized by maximum epsectral
%          amplitude.
%
% Usage:
%   matrix = normspectrogram(t, acc)
%   [matrix, matrix_t, matrix_f] = normspectrogram(t, acc)
%
% Where:
%   t:       Time array
%   acc:     Acceleration array (g)
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

%% Constants
MAX_FREQ = 14; % Max frequency of the matrix
NORMALIZE = true; % Do normalize windows
WINDOW_TIME = 5; % Time of each window
WINDOW_TIME_MOVEMENT = 2.5; % Movement of the windows

%% Check that length of arrays is the same
tlen = length(t);
acclen = length(acc);
if tlen ~= acclen
    error('Length of t and acc vectors must be the same');
end

%% Check that length of arrays are greather than 2
if tlen < 2
    error('Length of t and cc vector must be greater than 2');
end

%% Calculate dt
dt = t(2) - t(1);
if dt == 0
    error('dt is zero');
end

%% Check that vector length are greater than WINDOW_TIME/dt
win_size = WINDOW_TIME / dt;
if tlen < win_size
    error('Length of vectors does not meet minimal requierements');
end

%% Create frequency array
f = 1 / dt;
freq_arr = 0:f / win_size:f - 1 / win_size;
fsize = 0;
for i = 1:length(freq_arr)
    if freq_arr(i) < MAX_FREQ
        fsize = fsize + 1;
    else
        break
    end
end

%% Create matrix
% Calculate matrix length by time
t_ini = 0;
tarrsize = 1;
while true
    t_ini = t_ini + WINDOW_TIME_MOVEMENT;
    if t_ini + WINDOW_TIME > t(end)
        break;
    end
    tarrsize = tarrsize + 1;
end

% Create matrix
matrix = zeros(fsize, tarrsize);
matrix_t = linspace(0, t(end), tarrsize);
matrix_f = linspace(0, MAX_FREQ, fsize);

%% Create tuckey window (r=5%)
tuckey = tukeywin(win_size, 0.05);

%% Create 5-seconds windows overlapped by 2.5 seconds
t_ini = 0; % Initial time
t_indx = 1; % Index of initial time on t array
u = 1; % Number of window

% Start iteration
while true
    
    % Create window and acceleration window
    t_win = zeros(win_size, 1);
    acc_win = zeros(win_size, 1);
    
    % Copy data to window from t_ini to t_ini + WINDOW_TIME
    j = 1; % Index from t_win and acc_win arrays
    tmed_found = false; % If tmed_index is found
    for i = t_indx:t_indx + win_size - 1
        
        % Find index of next t_ini
        if ~tmed_found && t(i) >= t_ini + WINDOW_TIME_MOVEMENT
            t_indx = i;
            tmed_found = true;
        end
        
        % Store elements to windows
        t_win(j) = t(i);
        acc_win(j) = acc(i);
        j = j + 1;
    end
    
    %% Baseline correction
    acc_win = detrend(acc_win, 0);
    
    %% Apply tuckey window
    acc_win = acc_win .* tuckey;
    
    %% FFT
    acc_fft = fft(acc_win);
    
    %% Average 5-point smooth
    acc_fft = smooth(acc_fft);
    
    %% Calculate amplitude and normalize
    acc_fft = abs(acc_fft);
    acc_max = max(acc_fft);
    if NORMALIZE
        acc_norm = acc_fft ./ acc_max;
    else
        acc_norm = acc_fft; %#ok<*UNRCH>
    end
    
    %% Store data to matrix
    for freq = 1:fsize
        matrix(freq, u) = acc_norm(freq);
    end
    
    %% Advance initial window time
    t_ini = t_ini + WINDOW_TIME_MOVEMENT;
    if t_ini + WINDOW_TIME > t(end)
        break;
    end
    
    u = u + 1;
    
end

%% Store results in varargout
varargout{1} = matrix_t;
varargout{2} = matrix_f;

end

