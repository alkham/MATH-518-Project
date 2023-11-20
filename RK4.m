function y = RK4(f, y0, t)
    h = t(2) - t(1); % step size
    n = length(t);
    y = zeros(length(y0), n);
    y(:, 1) = y0;

    for i = 1:n-1
        k1 = f(t(i), y(:, i));
        k2 = f(t(i) + 0.5*h, y(:, i) + 0.5*h*k1);
        k3 = f(t(i) + 0.5*h, y(:, i) + 0.5*h*k2);
        k4 = f(t(i) + h, y(:, i) + h*k3);

        % Update step
        y_next = y(:, i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);

        % Ensure x (y(1)) stays within [0, 1]
        y_next(1) = min(max(y_next(1), 0), 1);

        % Update the solution
        y(:, i+1) = y_next;
    end
end
