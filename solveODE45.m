function [t_full, y_full] = solveODE45(K, tspan, y0)
    ode = @(t, y) [y(2); K/(1 - y(1)) - y(1)];

    options = odeset('Events', @boundaryEvent);
    [t, y] = ode45(ode, tspan, y0, options);

    % Check if the integration stopped early
    if t(end) < tspan(end)
        % Create additional time points
        t_additional = (t(end) + (t(2) - t(1))):tspan(2):tspan(end);
        y_additional = [ones(1, length(t_additional)); zeros(1, length(t_additional))];
        
        % Append the additional points to the original solution
        t_full = [t; t_additional'];
        y_full = [y; y_additional'];
    else
        t_full = t;
        y_full = y;
    end
end

function [value, isterminal, direction] = boundaryEvent(t, y)
    % Stop the integration if x (y(1)) goes out of [0, 1]
    value = [y(1) - 1; -y(1)]; % value = 0 when y(1) = 1 or y(1) = 0
    isterminal = [1; 1]; % 1 to stop integration
    direction = [0; 0]; % 0 to detect both increasing and decreasing through the boundary
end
