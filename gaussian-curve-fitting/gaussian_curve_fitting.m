clc;
clear;
close all;

sd = 0.3;
N = 40;   %Number of data
x = linspace(0, 1, N);
xn = 3 * sin(2 * pi * x);

g = random('norm', 0, 0.3, 1, 40);   %Normal distribution
tn1 = xn + g;
tn3 = sort(tn1); %Data for plotting gaussian prediction curve for each x
y = tn1;
y_curr = zeros(1,N);
alpha = 0.01;
%Considering M=3
w0 = 0;
w1 = 0;
w2 = 0;
w3 = 0;

for i=1:1000000
    y_curr = w0 + (w1 .* x) + (w2 .* (x .^ 2)) + (w3 .* (x .^ 3));
    c = (1/N) * sum((y-y_curr) .^ 2);   %cost funtion
    %Performing Gradient Descent
    w3g = -(2/N).*sum((y-y_curr).*(x.^3));
    w2g = -(2/N).*sum((y-y_curr).*(x.^2));
    w1g = -(2/N).*sum((y-y_curr).*x);
    w0g = -(2/N).*sum(y-y_curr);
    w3 = w3-(alpha*w3g);
    w2 = w2-(alpha*w2g);
    w1 = w1-(alpha*w1g);
    w0 = w0 - (alpha*w0g);
end

y_pred = w0 + w1.*x + w2 .* (x.^2) + w3 .* (x .^ 3);  %Predicted Curve
sigma = c;  %variance
plot(x, y_pred);  %Plotting predicted curve
hold on;

for i=1:1:N
   mean=y_pred(i);
   p = sqrt(1 / (2 * pi * sigma^2)) * exp((-1)*(tn3 - mean).^2 /(2*sigma^2));    %gaussian distribution
   p = p / 35;    %Scaling
   plot(p+x(i),tn3);
end
