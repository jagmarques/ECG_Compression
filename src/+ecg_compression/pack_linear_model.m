function payload = pack_linear_model(historyLength, coefficients, seedWindow, errorSignal)
%PACK_LINEAR_MODEL Bundle model metadata into a single vector.
%   payload = PACK_LINEAR_MODEL(historyLength, coefficients, seedWindow,
%   errorSignal) concatenates the regression metadata so that the signal can
%   be reconstructed downstream.

arguments
    historyLength (1, 1) double {mustBePositive, mustBeInteger}
    coefficients (:, 1) double
    seedWindow (:, 1) double
    errorSignal (:, 1) double
end

payload = [historyLength; coefficients(:); seedWindow(:); errorSignal(:)];
end
