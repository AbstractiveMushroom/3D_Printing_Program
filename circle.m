% Funkcja umo¿liwia wykreœlenie wycinka ko³a o zadanym k¹cie
% przy dodatnim k¹cie ruch wykonywany w kierunku przeciwnym do wskazówek
% zegara, a przy ujemny w kierunku przeciwnym.
% Przyk³ad (k¹t_alfa = 457):
% circle(s,457,200); %wycinek ko³a o zadanym k¹cie - przeciwnie do wskazówek zegara
% circle(s,-457,200); % zgodnie ze wskazówkami zegara
% Drukarka wykona ruch i wróci na pozycjê startow¹.

function [] = circle(s,degrees,size)
%[]=circle(port szeregowy, k¹t wycinka ko³a, wielkoœæ ko³a)

degrees=round(degrees,2); %zaokr¹glanie
sign=1;
a=1;

if degrees<0 %sprawdzanie kierunku ruchu
    degrees=abs(degrees);
    sign=-1;
end

eng1=round(size*sin(0*pi)); %pocz¹tkowe "pozycje" silników
eng2=round(size*sin(-(2/3)*pi));
eng3=round(size*sin(-(4/3)*pi));

commands=cell([1,numel(0:0.01:degtorad(degrees))]); %zdefiniowanie zmiennej komórkowej 
i=1;

for t=0:0.01:degtorad(degrees)

    tEng1=round(size*sin(t-0*pi)); % nowe "pozycje" silników
    tEng2=round(size*sin(t-(2/3)*pi));
    tEng3=round(size*sin(t-(4/3)*pi));

    commands{i}=[tEng1-eng1,tEng2-eng2,tEng3-eng3]; %zapisanie listy kroków

    eng1=tEng1; %przypisanie nowych "pozycji" pocz¹tkowych silników
    eng2=tEng2;
    eng3=tEng3;

    i=i+1;
end

if sign ==-1 %ustawienie znaku i okreœlenie kolejnoœci odczytu komend
    a=-1;
    j=numel(commands):-1:1;
else   
    j=1:1:numel(commands);
end
       
for i=j
    steps=commands{i};
    move(s,steps(1)*a,steps(2)*a,steps(3)*a); %przesy³ komend do drukarki
end
           
end