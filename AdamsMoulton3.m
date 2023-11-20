function y = AdamsMoulton3(f, y0, t)
    h = t(2) - t(1); % step size
    n = length(t);
    y = zeros(length(y0), n);

    % Initialize first few values with ode45
    [~, y_ode45] = ode45(f, t(1:4), y0); % Assuming 4 steps are enough
    y(:, 1:4) = y_ode45.';

    % Adams-Moulton method
    for i = 4:n-1
        % Predictor (Adams-Bashforth 2-step method)
        predictor = y(:, i) + h * (1.5 * f(t(i), y(:, i)) - 0.5 * f(t(i-1), y(:, i-1)));
        
        % Limit predictor to the range [0, 1] if necessary
        predictor(1) = min(max(predictor(1), 0), 1);

        % Corrector (Adams-Moulton 3-step method)
        y(:, i+1) = y(:, i) + h * (0.25 * f(t(i+1), predictor) + 0.75 * f(t(i), y(:, i)));

        % Limit y to the range [0, 1] if necessary
        y(1, i+1) = min(max(y(1, i+1), 0), 1);
    end
end
