function [ valueCheck ] = lotkavolterra(a, b, c, d, lambda1, lambda2, x2, koefc, alp2, k, beta1, beta2)
% функция возвращает логический результат проверки параметров
% Описание переменных
% psi - (пси)
% dt - шаг дискретизации по времени
% u - обозначение управления
% fi - внутреннее управление (фи)
% E1 - шумы (эпсилон 1)
% x - жертвы (X1)
% y - хищники(X2)

% установить шаг
dt = 0.1;
% предельное время
seconds = 17; 
iterations = ceil(seconds/dt); 

% prey - жертвы => X1
x = zeros(iterations);
% predators - хищники => X2
y = zeros(iterations);

u = zeros(iterations); % управление
psi1 = zeros(iterations);
psi = zeros(iterations);
E1 = zeros(iterations);
fi = zeros(iterations);
fi1 = zeros(iterations);


% задаем начальные значения
E1(1) = normrnd(0,0.1);
y(2) = 10;
x(2) = 5; 
psi(1) = 0; 
valueCheck = 1; %установим значение логической переменной в true


for i = 2:iterations
    E1(i+1) = normrnd(0,0.1); % шумы

    fi1(i) = - (dt * k * beta1).^(-1) * (y(i) + dt * (y(i)*(d*x(i) - c))).^(-1)*...
    (lambda2 + 1) * (y(i) + dt * (y(i)*(d*x(i) - c)) - x2) + alp2 * (k*beta1).^(-1); % шестое уравнение

    fi(i) = - (dt * beta2 * y(i)).^(-1) * (lambda2 + 1) * psi(i) + alp2 * (beta2).^(-1); % пятое уравнение => внутреннее управление

    psi(i) = y(i) - x2; % ограничение согласно заданию X2(t)-X2* - четвертое уравнение 4.2

    psi1(i) = x(i) - fi(i); % четвертое уравнение 4.1

    u(i) = -(lambda1 + koefc)*psi1(i) - koefc*lambda1*psi1(i-1) - x(i) - dt*(x(i)*(a - b*y(i))) + fi1(i); % управление - третье уравнение => формула для управления  

    y(i+1) = y(i) + (y(i)*(d*x(i)-c))*dt; % X2 - второе уравнение => хищники

    x(i+1) = x(i) + (x(i)*(a - b*y(i)))*dt + u(i) + E1(i+1) + E1(i)*koefc; % X1 - первое уравнение => жертвы
% устанавливаем ограничения
 if ((x(i) > 200) || (y(i) > 200))
     valueCheck = 0;
 end


end
 
end




% end