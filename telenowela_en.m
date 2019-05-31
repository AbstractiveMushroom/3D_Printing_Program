if ~(exist('s','var')) %sprawdzenie statusu portu
%     s = serial('/dev/ttyUSB0'); % LINUX
s = serial('COM9'); % WINDOWS
    s.BaudRate = 115200;
else
    if s.Status(1) == 'o' %ewentualne zamkniêcie portu
        fclose(s);
    end
end

move(s,1000,1000,1000,3,1); %ruch w górê: move(serial,s1,s2,s3,repeat,pauza)
% repeat - ile razy ma powtórzyæ move (counter in for loop)
% pauza - boolean - czy wykonaæ funkcjê pause*
% *nale¿y u¿yæ pauza = 1 kiedy u¿ywasz bezpoœrednio move
% natomiast circle wywo³uje to z wartoœci¹ pauza = 0; 

% czas trwania move: 5 seconds - powinno byæ dostosowane do iloœci kroków
% oraz ustawione w Arduino prêdkoœci

% przy zamkniêtym porcie szeregowym jest on otwierany z 1 sekundow¹ pauz¹
move(s,-4000,-4000,-4000,1,1); %ruch w dó³

% rysowanie kó³
circle(s,360,200); %wycinek ko³a o zadanym k¹cie - przeciwnie do wskazówek zegara
circle(s,-360,200); % zgodnie ze wskazówkami zegara

if s.Status(1) == 'o' %zamkniêcie portu po zakoñczeniu operacji
    fclose(s);
end