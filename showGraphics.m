function[ ] = showGraphics(a, b, c, d, lambda1, lambda2, x2, koefc, alp2, k, beta1, beta2)
% функция для отображения графиков

% установить шаг 0.01
dt = 0.5;
% предельное время
seconds = 60; 
% for the loop
iterations = ceil(seconds/dt); 
% forp plotting
time = 0:dt:seconds;

% prey - жертвы => X1
x = zeros(1,iterations);
% predators - хищники => X2
y = zeros(1,iterations); 

u = zeros(1,iterations); % управление
psi1 = zeros(1,iterations);
psi = zeros(1,iterations);
E1 = zeros(1,iterations);
fi = zeros(1,iterations);
fi1 = zeros(1,iterations);

% устанавливаем начальные значения
E1(1) = normrnd(0,0.1);
y(2) = 10;
x(2) = 5; 
psi(1) = 0; 


for i = 2:iterations
        E1(1,i+1) = normrnd(0,0.1); % шумы

        fi1(1,i) = - (dt * k * beta1).^(-1) * (y(1,i) + dt * (y(1,i)*(d*x(1,i) - c))).^(-1)*...
          (lambda2 + 1) * (y(1,i) + dt * (y(1,i)*(d*x(1,i) - c)) - x2) + alp2 * (k*beta1).^(-1); % шестое уравнение
      
        fi(1,i) = - (dt * beta2 * y(1,i)).^(-1) * (lambda2 + 1) * psi(1,i) + alp2 * (k*beta1).^(-1); % пятое уравнение
        
        psi(1,i) = y(1,i) - x2; % ограничение согласно заданию X2(t)-X2* - четвертое уравнение 4.2
        
        psi1(1,i) = x(1,i) - fi(1,i); % четвертое уравнение 4.1
        
        u(1,i) = -(lambda1 + koefc)*psi1(1,i) - koefc*lambda1*psi1(1,i-1) - x(1,i) - dt*(x(1,i)*(a - b*y(1,i))) + fi1(1,i); % управление - третье уравнение    
        
        x(1,i+1) = x(1,i) + (x(1,i)*(a - b*y(1,i)))*dt + u(1,i) + E1(1,i+1) + E1(1,i)*koefc; % X1 - первое уравнение
        
        y(1,i+1) = y(1,i) + (y(1,i)*(d*x(1,i)-c))*dt; % X2 - второе уравнение
end

% график 1
figure(4)
plot(time, x, 'blue')
hold on % сохраняет текущие графики
plot(time, y, 'red')

        xlabel('time')
        ylabel('population')
        % подпись
        hleg1 = legend('prey','predators');
        set(hleg1,'Location','NorthEast')
        line1 = sprintf('a = %.3f, b=%.3f, c=%.3f, d=%.3f, dt=%.3f, lambda1=%.3f, lambda2=%.3f and X2*=%.3f', a,b,c,d,dt,lambda1,lambda2,x2);
        line2 = sprintf('C = %.3f, alpha2=%.3f, k=%.3f, beta1=%.3f and beta2=%.3f', koefc, alp2, k, beta1, beta2);
        title({line1, line2})
       
        
figure(5)
plot(x, y, 'blue')
xlabel('prey population')
ylabel('predator population')
title('system dynamics in the phase plane')
line1 = sprintf('a = %.3f, b=%.3f, c=%.3f, d=%.3f, dt=%.3f, lambda1=%.3f, lambda2=%.3f and X2*=%.3f', a,b,c,d,dt,lambda1,lambda2,x2);
        line2 = sprintf('C = %.3f, alpha2=%.3f, k=%.3f, beta1=%.3f and beta2=%.3f', koefc, alp2, k, beta1, beta2);
        title({line1, line2})

end

