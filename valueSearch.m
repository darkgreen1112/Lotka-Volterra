% ��� �������� �������� �������������
% ��������� ����
fil = fopen('file.txt', 'a');

% ������������� �������� ��������
x2 = 10; % ������� �������� ��������
koefc = 0.001; 
alp2 = 0.4;
k = 1;
beta1 = 0.1;
beta2 = 0.3;

% ������ ����� �������� �������� ����������
for a = 0.1:0.1:1.0
    
    for b = 0.1:0.1:1.0 
        
        for c = 0.1:0.1:1.0
            
            for d = 0.1:0.1:1.0
                
                 for lambda1 = 0.1:0.1:1.0
                     
                      for lambda2 = 0.1:0.1:1.0   
                      % �������� ��������� � ������� ��������
                    [ valueCheck ] = lotkavolterra(a, b, c, d, lambda1, lambda2, x2, koefc, alp2, k, beta1, beta2); 
                      %���������� � ���� �������� �������������
                      if valueCheck == 1
                              fprintf(fil, '%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d\n', a, b, c, d, lambda1, lambda2, x2, koefc, alp2, k, beta1, beta2);
                      end
                      
                      end
                      
                 end
                 
            end
            
        end
        
    end
    
end

                                    
       
fclose(fid); % �������� �����

                                      