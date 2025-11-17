function deltaSignal = delta_modulate(signal)
%DELTA_MODULATE Compute the first-order difference of the signal.
%   deltaSignal = DELTA_MODULATE(signal) returns the discrete derivative of
%   SIGNAL, which emulates delta modulation.

arguments
    signal (:, 1) double
end

deltaSignal = diff(signal);
end
