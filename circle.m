%% Dobrosław Cieślewicz, Grzegorz Maślak, Michał Kolenderski 2019

% Funkcja umożliwia wykreślenie wycinka koła o zadanym kącie
% przy dodatnim kącie ruch wykonywany w kierunku przeciwnym do wskazówek
% zegara, a przy ujemny w kierunku przeciwnym.
% Przykład (kąt_alfa = 457):
% circle(s,457,200); %wycinek koła o zadanym kącie - przeciwnie do wskazówek zegara
% circle(s,-457,200); % zgodnie ze wskazówkami zegara
% Drukarka wykona ruch i wróci na pozycję startową.

function [] = circle(s,degrees,size)
%[]=circle(port szeregowy, kąt wycinka koła, wielkość koła)

degrees=round(degrees,2); %zaokrąglanie
sign=1;
a=1;

if degrees<0 %sprawdzanie kierunku ruchu
    degrees=abs(degrees);
    sign=-1;
end

eng1=round(size*sin(0*pi)); %początkowe "pozycje" silników
eng2=round(size*sin(-(2/3)*pi));
eng3=round(size*sin(-(4/3)*pi));

commands=cell([1,numel(0:0.01:degtorad(degrees))]); %zdefiniowanie zmiennej komórkowej 
i=1;

for t=0:0.01:degtorad(degrees)

    tEng1=round(size*sin(t-0*pi)); % nowe "pozycje" silników
    tEng2=round(size*sin(t-(2/3)*pi));
    tEng3=round(size*sin(t-(4/3)*pi));

    commands{i}=[tEng1-eng1,tEng2-eng2,tEng3-eng3]; %zapisanie listy kroków

    eng1=tEng1; %przypisanie nowych "pozycji" początkowych silników
    eng2=tEng2;
    eng3=tEng3;

    i=i+1;
end

if sign ==-1 %ustawienie znaku i określenie kolejności odczytu komend
    a=-1;
    j=numel(commands):-1:1;
else   
    j=1:1:numel(commands);
end
       
for i=j
    steps=commands{i};
    move(s,steps(1)*a,steps(2)*a,steps(3)*a); %przesył komend do drukarki
end
           
end
