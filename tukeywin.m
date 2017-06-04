function w = tukeywin(n, r)
%TUKEYWIN Tukey window.
error(nargchk(1, 2, nargin, 'struct')); %#ok<NCHKN>

% Default value for R parameter.
if nargin < 2 || isempty(r)
    r = 0.500;
end

[n, w, trivialwin] = check_order(n);
if trivialwin, return, end

if r <= 0
    w = ones(n, 1);
elseif r >= 1
    w = hann(n);
else
    t = linspace(0, 1, n)';
    % Defines period of the taper as 1/2 period of a sine wave.
    per = r / 2;
    tl = floor(per*(n - 1)) + 1;
    th = n - tl + 1;
    % Window is defined in three sections: taper, constant, taper
    w = [((1 + cos(pi/per*(t(1:tl) - per))) / 2); ones(th-tl-1, 1); ((1 + cos(pi/per*(t(th:end) - 1 + per))) / 2)];
end