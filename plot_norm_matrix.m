function plot_norm_matrix(m, mt, mf, t, acc, regname)
% PLOT_NORM_MATRIX Plot normalized spectrogram alonside acceleration
% data.
%
% Usage:
%   plot_norm_matrix(m, mt, mf, t, acc, regname)
%
% Where:
%   m:  	 Normalized matrix
%   mt:      Time array from matrix
%   mf:      Frequency array from matrix
%   t:       Time of the seismic data
%   acc:     Acceleration of seismic data
%   regname: Name of the seismic data (plot title)
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

%% If regname is not defined
if ~exist('regname', 'var')
    regname = '';
end

%% Plot matrix
figure();

%% Plot matrix
subplot(2, 1, 1);
title(regname);
hold on;
pcolor(mt, mf, m); shading interp; % Plot colormap
[~, h] = contour(mt, mf, m, [0.8, 0.8]); % Plot contour at 80%
h.LineWidth = 0.5;
h.LineColor = 'red';
hold off;
ylabel('frequency (Hz)');
xlim([0, mt(end)]);
ylim([0.4, mf(end)]);

%% Plot seismic
subplot(2, 1, 2);
plot(t, acc, 'k');
xlabel('Time (s)');
ylabel('a (g)');
xlim([0, t(end)]);
grid on;

end

