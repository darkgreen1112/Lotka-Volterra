function[ ] = showGraphics(a, b, c, d, lambda1, lambda2, x2, koefc, alp2, k, beta1, beta2)
% ������� ��� ����������� ��������

% ���������� ��� 0.01
dt = 0.1;
% ���������� �����
seconds = 60; 
% for the loop
iterations = ceil(seconds/dt); 
% forp plotting
time = 0:dt:seconds;

% prey - ������ => X1
x = zeros(1,iterations);
% predators - ������� => X2
y = zeros(1,iterations); 

u = zeros(1,iterations); % ����������
psi1 = zeros(1,iterations);
psi = zeros(1,iterations);
E1 = zeros(1,iterations);
fi = zeros(1,iterations);
fi1 = zeros(1,iterations);

% ������������� ��������� ��������
E1(1) = normrnd(0,0.1);
y(2) = 10;
x(2) = 5; 
psi(1) = 0; 


for i = 2:iterations
        E1(1,i+1) = normrnd(0,0.1); % ����

        fi1(1,i) = - (dt * k * beta1).^(-1) * (y(1,i) + dt * (y(1,i)*(d*x(1,i) - c))).^(-1)*...
          (lambda2 + 1) * (y(1,i) + dt * (y(1,i)*(d*x(1,i) - c)) - x2) + alp2 * (k*beta1).^(-1); % ������ ���������
      
        fi(1,i) = - (dt * beta2 * y(1,i)).^(-1) * (lambda2 + 1) * psi(1,i) + alp2 * (k*beta1).^(-1); % ����� ���������
        
        psi(1,i) = y(1,i) - x2; % ����������� �������� ������� X2(t)-X2* - ��������� ��������� 4.2
        
        psi1(1,i) = x(1,i) - fi(1,i); % ��������� ��������� 4.1
        
        u(1,i) = -(lambda1 + koefc)*psi1(1,i) - koefc*lambda1*psi1(1,i-1) - x(1,i) - dt*(x(1,i)*(a - b*y(1,i))) + fi1(1,i); % ���������� - ������ ���������    
        
        x(1,i+1) = x(1,i) + (x(1,i)*(a - b*y(1,i)))*dt + u(1,i) + E1(1,i+1) + E1(1,i)*koefc; % X1 - ������ ���������
        
        y(1,i+1) = y(1,i) + (y(1,i)*(d*x(1,i)-c))*dt; % X2 - ������ ���������
end

% ������ 1
figure(4)
plot(time, x, 'blue')
hold on % ��������� ������� �������
plot(time, y, 'red')

        xlabel('time')
        ylabel('population')
        % �������
        hleg1 = legend('prey','predators');
        set(hleg1,'Location','NorthEast')
       
        
figure(5)
plot(x, y, 'blue')
xlabel('prey population')
ylabel('predator population')
title('system dynamics in the phase plane')

end
