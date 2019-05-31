function [] = move(s,s1,s2,s3,repeat,pauza)
%[]=move(port szeregowy, kroki silnik 1, kroki silnik 2, kroki silnik 3)
%[]=move(port szeregowy, kroki silnik 1, kroki silnik 2, kroki silnik 3, ilo�� powt�rze�)

if nargin < 5 || isempty(repeat) %okre�lenie liczby argument�w wej�ciowych
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
        if (pauza) % to wywo�uje si� gdy u�ywamy move bezpo�rednio
            pause(5);
        end
      
    catch
        fprintf('Error');
    end

    if ~(pauza) % to wykonuje si� gdy funkcja circle wywo�uje move
        while(s.BytesAvailable == 0)
        end

        while(s.BytesAvailable>0)
        fscanf(s)
        end
        
    end

end

end