function deltaSignal = delta_modulate(signal)
% Return the discrete derivative to mimic delta modulation.

arguments
    signal (:, 1) double
end

deltaSignal = diff(signal);
end
