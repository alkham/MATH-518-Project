y0 = [0; 0]; % Initial conditions x(0) = 0, dx/dt(0) = 0
tspan = 0:0.01:30; % Time span from 0 to 10 with a step size of 0.01
eps = 10^(-15);


K_values = [0.1, 0.175, 0.203632188, 0.22];
num_K = length(K_values);

rk4_solutions = cell(1, num_K);
euler_solutions = cell(1, num_K);
adams_solutions = cell(1, num_K);
ode45_solutions = cell(1, num_K);

rk4_errors = cell(1, num_K);
euler_errors = cell(1, num_K);
adams_errors = cell(1, num_K);

for i = 1:num_K
    K = K_values(i);
    
    % Runge-Kutta Method
    rk4_solutions{i} = RK4(@(t, y) odeSystem(t, y, K), y0, tspan);
    
    % Euler's Method
    euler_solutions{i} = Euler(@(t, y) odeSystem(t, y, K), y0, tspan);
    
    % Adams-Moulton Method
    adams_solutions{i} = AdamsMoulton3(@(t, y) odeSystem(t, y, K), y0, tspan);
    
    % Reference Solution (ode45)
    [t_ref, y_ref] = solveODE45(K, tspan, y0);
    ode45_solutions{i} = [t_ref, y_ref(:,1)];

    % Errors for each method
    rk4_errors{i} = rmse(rk4_solutions{i}(1,:), transpose(ode45_solutions{i}(:, 2)));
    euler_errors{i} = rmse(euler_solutions{i}(1,:), transpose(ode45_solutions{i}(:, 2)));
    adams_errors{i} = rmse(adams_solutions{i}(1,:), transpose(ode45_solutions{i}(:, 2)));
end



for i = 1:length(K_values)
    K = K_values(i);
    
    % Extract the solutions for each method
    rk4_solution = rk4_solutions{i};
    euler_solution = euler_solutions{i};
    adams_solution = adams_solutions{i};
    ode45_solution = ode45_solutions{i};
    
    % Create a new figure for each K
    figure;

    % Plot RK4 Solution
    plot(tspan, rk4_solution(1,:), 'b', 'DisplayName', 'RK4');
    hold on;

    % Plot Euler Solution
    plot(tspan, euler_solution(1,:), 'r', 'DisplayName', 'Euler');

    % Plot Adams-Moulton Solution
    plot(tspan, adams_solution(1,:), 'g', 'DisplayName', 'Adams-Moulton');

    % Plot ode45 Solution
    plot(ode45_solution(:,1), ode45_solution(:,2), 'k', 'DisplayName', 'ode45');

    % Customize the plot
    title(['Solutions for K = ', num2str(K)]);
    xlabel('Time');
    ylabel('Solution');
    legend;
    hold off;
end
