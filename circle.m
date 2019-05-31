% Funkcja umo�liwia wykre�lenie wycinka ko�a o zadanym k�cie
% przy dodatnim k�cie ruch wykonywany w kierunku przeciwnym do wskaz�wek
% zegara, a przy ujemny w kierunku przeciwnym.
% Przyk�ad (k�t_alfa = 457):
% circle(s,457,200); %wycinek ko�a o zadanym k�cie - przeciwnie do wskaz�wek zegara
% circle(s,-457,200); % zgodnie ze wskaz�wkami zegara
% Drukarka wykona ruch i wr�ci na pozycj� startow�.

function [] = circle(s,degrees,size)
%[]=circle(port szeregowy, k�t wycinka ko�a, wielko�� ko�a)

degrees=round(degrees,2); %zaokr�glanie
sign=1;
a=1;

if degrees<0 %sprawdzanie kierunku ruchu
    degrees=abs(degrees);
    sign=-1;
end

eng1=round(size*sin(0*pi)); %pocz�tkowe "pozycje" silnik�w
eng2=round(size*sin(-(2/3)*pi));
eng3=round(size*sin(-(4/3)*pi));

commands=cell([1,numel(0:0.01:degtorad(degrees))]); %zdefiniowanie zmiennej kom�rkowej 
i=1;

for t=0:0.01:degtorad(degrees)

    tEng1=round(size*sin(t-0*pi)); % nowe "pozycje" silnik�w
    tEng2=round(size*sin(t-(2/3)*pi));
    tEng3=round(size*sin(t-(4/3)*pi));

    commands{i}=[tEng1-eng1,tEng2-eng2,tEng3-eng3]; %zapisanie listy krok�w

    eng1=tEng1; %przypisanie nowych "pozycji" pocz�tkowych silnik�w
    eng2=tEng2;
    eng3=tEng3;

    i=i+1;
end

if sign ==-1 %ustawienie znaku i okre�lenie kolejno�ci odczytu komend
    a=-1;
    j=numel(commands):-1:1;
else   
    j=1:1:numel(commands);
end
       
for i=j
    steps=commands{i};
    move(s,steps(1)*a,steps(2)*a,steps(3)*a); %przesy� komend do drukarki
end
           
end