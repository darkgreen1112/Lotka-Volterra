% для перебора значений коэффициентов
% открываем файл
fil = fopen('file.txt', 'a');

% устанавливаем значения констант
x2 = 10; % целевое значение хищников
koefc = 0.001; 
alp2 = 0.4;
k = 1;
beta1 = 0.1;
beta2 = 0.3;

% задаем циклы перебора значений параметров
for a = 0.1:0.1:1.0
    
    for b = 0.1:0.1:1.0 
        
        for c = 0.1:0.1:1.0
            
            for d = 0.1:0.1:1.0
                
                 for lambda1 = 0.1:0.1:1.0
                     
                      for lambda2 = 0.1:0.1:1.0   
                      % передаем параметры в функцию проверки
                    [ valueCheck ] = lotkavolterra(a, b, c, d, lambda1, lambda2, x2, koefc, alp2, k, beta1, beta2); 
                      %записываем в файл значения коэффициентов
                      if valueCheck == 1
                              fprintf(fil, '%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d\n', a, b, c, d, lambda1, lambda2, x2, koefc, alp2, k, beta1, beta2);
                      end
                      
                      end
                      
                 end
                 
            end
            
        end
        
    end
    
end

                                    
       
fclose(fid); % закрытие файла

                                      
                                      
