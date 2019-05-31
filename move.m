function [] = move(s,s1,s2,s3,repeat,pauza)
%[]=move(port szeregowy, kroki silnik 1, kroki silnik 2, kroki silnik 3)
%[]=move(port szeregowy, kroki silnik 1, kroki silnik 2, kroki silnik 3, iloœæ powtórzeñ)

if nargin < 5 || isempty(repeat) %okreœlenie liczby argumentów wejœciowych
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
        if (pauza) % to wywo³uje siê gdy u¿ywamy move bezpoœrednio
            pause(5);
        end
      
    catch
        fprintf('Error');
    end

    if ~(pauza) % to wykonuje siê gdy funkcja circle wywo³uje move
        while(s.BytesAvailable == 0)
        end

        while(s.BytesAvailable>0)
        fscanf(s)
        end
        
    end

end

end