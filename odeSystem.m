function dy = odeSystem(t, y, K)
    dy = zeros(2,1);
    x = y(1);
    x = min(x, 1 - eps); % Ensuring x is less than 1, eps is a very small number
    dy(1) = y(2);
    dy(2) = K/(1 - x) - x;
end
