%% Dobrosław Cieślewicz, Grzegorz Maślak, Michał Kolenderski 2019

function [] = move(s,s1,s2,s3,repeat,pauza)
%[]=move(port szeregowy, kroki silnik 1, kroki silnik 2, kroki silnik 3)
%[]=move(port szeregowy, kroki silnik 1, kroki silnik 2, kroki silnik 3, ilość powtórzeń)

if nargin < 5 || isempty(repeat) %określenie liczby argumentów wejściowych
    repeat=1;
end

if nargin < 6
    pauza=0;
end


if s.Status(1) == 'c'
    fopen(s);
    pause(1);
end

for i=1:repeat

    try
        fprintf(s, sprintf('s1 %d s2 %d s3 %d',s1,s2,s3));
        if (pauza) % to wywołuje się gdy używamy move bezpośrednio
            pause(5);
        end
      
    catch
        fprintf('Error');
    end

    if ~(pauza) % to wykonuje się gdy funkcja circle wywołuje move
        while(s.BytesAvailable == 0)
        end

        while(s.BytesAvailable>0)
        fscanf(s)
        end
        
    end

end

end
