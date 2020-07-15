function [ valueCheck ] = lotkavolterra(a, b, c, d, lambda1, lambda2, x2, koefc, alp2, k, beta1, beta2)
% ������� ���������� ���������� ��������� �������� ����������
% �������� ����������
% psi - (���)
% dt - ��� ������������� �� �������
% u - ����������� ����������
% fi - ���������� ���������� (��)
% E1 - ���� (������� 1)
% x - ������ (X1)
% y - �������(X2)

% ���������� ���
dt = 0.1;
% ���������� �����
seconds = 17; 
iterations = ceil(seconds/dt); 

% prey - ������ => X1
x = zeros(iterations);
% predators - ������� => X2
y = zeros(iterations);

u = zeros(iterations); % ����������
psi1 = zeros(iterations);
psi = zeros(iterations);
E1 = zeros(iterations);
fi = zeros(iterations);
fi1 = zeros(iterations);


% ������ ��������� ��������
E1(1) = normrnd(0,0.1);
y(2) = 10;
x(2) = 5; 
psi(1) = 0; 
valueCheck = 1; %��������� �������� ���������� ���������� � true


for i = 2:iterations
    E1(i+1) = normrnd(0,0.1); % ����

    fi1(i) = - (dt * k * beta1).^(-1) * (y(i) + dt * (y(i)*(d*x(i) - c))).^(-1)*...
    (lambda2 + 1) * (y(i) + dt * (y(i)*(d*x(i) - c)) - x2) + alp2 * (k*beta1).^(-1); % ������ ���������

    fi(i) = - (dt * beta2 * y(i)).^(-1) * (lambda2 + 1) * psi(i) + alp2 * (beta2).^(-1); % ����� ��������� => ���������� ����������

    psi(i) = y(i) - x2; % ����������� �������� ������� X2(t)-X2* - ��������� ��������� 4.2

    psi1(i) = x(i) - fi(i); % ��������� ��������� 4.1

    u(i) = -(lambda1 + koefc)*psi1(i) - koefc*lambda1*psi1(i-1) - x(i) - dt*(x(i)*(a - b*y(i))) + fi1(i); % ���������� - ������ ��������� => ������� ��� ����������  

    y(i+1) = y(i) + (y(i)*(d*x(i)-c))*dt; % X2 - ������ ��������� => �������

    x(i+1) = x(i) + (x(i)*(a - b*y(i)))*dt + u(i) + E1(i+1) + E1(i)*koefc; % X1 - ������ ��������� => ������
% ������������� �����������
 if ((x(i) > 200) || (y(i) > 200))
     valueCheck = 0;
 end


end
 
end




% end