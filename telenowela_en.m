%% Dobrosław Cieślewicz, Grzegorz Maślak, Michał Kolenderski 2019


if ~(exist('s','var')) %sprawdzenie statusu portu
%     s = serial('/dev/ttyUSB0'); % LINUX
s = serial('COM9'); % WINDOWS
    s.BaudRate = 115200;
else
    if s.Status(1) == 'o' %ewentualne zamknięcie portu
        fclose(s);
    end
end

move(s,1000,1000,1000,3,1); %ruch w górę: move(serial,s1,s2,s3,repeat,pauza)
% repeat - ile razy ma powtórzyć move (counter in for loop)
% pauza - boolean - czy wykonać funkcję pause*
% *należy użyć pauza = 1 kiedy używasz bezpośrednio move
% natomiast circle wywołuje to z wartością pauza = 0; 

% czas trwania move: 5 sekund - powinno być dostosowane do ilości kroków
% oraz ustawione w Arduino prędkości

% przy zamkniętym porcie szeregowym jest on otwierany z 1 sekundową pauzą
move(s,-4000,-4000,-4000,1,1); %ruch w dół

% rysowanie kół
circle(s,360,200); %wycinek koła o zadanym kącie - przeciwnie do wskazówek zegara
circle(s,-360,200); % zgodnie ze wskazówkami zegara

if s.Status(1) == 'o' %zamknięcie portu po zakończeniu operacji
    fclose(s);
end
