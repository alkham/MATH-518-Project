function y = Euler(f, y0, t)
    h = t(2) - t(1); % step size
    n = length(t);
    y = zeros(length(y0), n);
    y(:, 1) = y0;

    for i = 1:n-1
        % Compute the next step
        y_next = y(:, i) + h * f(t(i), y(:, i));

        % Ensure x (y(1)) stays within [0, 1]
        y_next(1) = min(max(y_next(1), 0), 1);

        % Update the solution
        y(:, i+1) = y_next;
    end
end
