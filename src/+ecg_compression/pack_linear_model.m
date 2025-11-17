function payload = pack_linear_model(historyLength, coefficients, seedWindow, errorSignal)
% Concatenate model metadata so the signal can be rebuilt.

arguments
    historyLength (1, 1) double {mustBePositive, mustBeInteger}
    coefficients (:, 1) double
    seedWindow (:, 1) double
    errorSignal (:, 1) double
end

payload = [historyLength; coefficients(:); seedWindow(:); errorSignal(:)];
end
