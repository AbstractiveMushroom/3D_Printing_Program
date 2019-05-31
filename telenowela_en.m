if ~(exist('s','var')) %sprawdzenie statusu portu
%     s = serial('/dev/ttyUSB0'); % LINUX
s = serial('COM9'); % WINDOWS
    s.BaudRate = 115200;
else
    if s.Status(1) == 'o' %ewentualne zamkni�cie portu
        fclose(s);
    end
end

move(s,1000,1000,1000,3,1); %ruch w g�r�: move(serial,s1,s2,s3,repeat,pauza)
% repeat - ile razy ma powt�rzy� move (counter in for loop)
% pauza - boolean - czy wykona� funkcj� pause*
% *nale�y u�y� pauza = 1 kiedy u�ywasz bezpo�rednio move
% natomiast circle wywo�uje to z warto�ci� pauza = 0; 

% czas trwania move: 5 seconds - powinno by� dostosowane do ilo�ci krok�w
% oraz ustawione w Arduino pr�dko�ci

% przy zamkni�tym porcie szeregowym jest on otwierany z 1 sekundow� pauz�
move(s,-4000,-4000,-4000,1,1); %ruch w d�

% rysowanie k�
circle(s,360,200); %wycinek ko�a o zadanym k�cie - przeciwnie do wskaz�wek zegara
circle(s,-360,200); % zgodnie ze wskaz�wkami zegara

if s.Status(1) == 'o' %zamkni�cie portu po zako�czeniu operacji
    fclose(s);
end