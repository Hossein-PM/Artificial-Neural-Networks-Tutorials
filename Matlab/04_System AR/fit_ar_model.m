function [weights, mse] = fit_ar_model(x, y, order)
    X = [];
    for t = order+1:length(y)
        row = [];
        for i = 1:order
            row = [row, y(t-i), x(t-i)];  
        end
        X = [X; row];
    end

    y_train = y(order+1:end)';
    weights = (X' * X) \ (X' * y_train);
    
    y_pred = X * weights;
    mse = mean((y_train - y_pred).^2);
end