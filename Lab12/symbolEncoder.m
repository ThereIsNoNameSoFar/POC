% Tomasz Kryjak, Tomasz Pieciak
% Laboratorium Biocybernetyki AGH

% Proste obliczenie kompresji za pomoce RLE i kodowania Huffmana 

% Parametry
% Wejscie : 
%   - obraz - oryginalny obraz (przed DCT)
%   - obrazKwantyzacja - obraz po etapie kwantyzacji

% Wyjscie:
%   - oryginalSize  - rozmiar oryginalny     (w bajtach)
%   - RLESize       - rozmiar po RLE         (w bajtach)
%   - huffmanSize   - rozmiar po Huffmanie   (w bajtach)


function [oryginalSize RLESize huffmanSize ] = symbolEncoder(obraz, obrazKwantyzacja ) 

    x = double(obraz) - 128; 
   
    [X Y] = size(x);
    oryginalSize = X * Y; 
    % Tablica do zig - zag
    order = [  1  9  2  3 10 17 25 18 11  4  5 12 19 26 33 ...
          41 34 27 20 13  6  7 14 21 28 35 42 49 57 50 ...
          43 36 29 22 15  8 16 23 30 37 44 51 58 59 52 ...
          45 38 31 24 32 39 46 53 60 61 54 47 40 48 55 ...
          62 63 56 64 ];

    % Podzial bloki 8x8 na kolumny
    y = im2col(obrazKwantyzacja, [ 8 8], 'distinct');

    % Ilosc blokow
    ilBlokow = size(y,2);

    % Zig - zag 
    y = y(order,:);

    % Symbol zakonczenia bloku
    eob = max(x(:) +1 );

    % Tablica na wynik
    r = zeros(numel(y) + size(y,2) ,1 );

    
    %Kodowanie RLE
    count = 0;

    for j=1:ilBlokow
        i = max(find(y(:,j)));
        if (isempty(i) )
            i = 0;
        end
        p = count +1;
        q = p+i;
        r(p:q) = [y(1:i,j);eob];
        count = count +i +1;
    end

    % Usuniecie nieuzywanych pozycji
    r((count+1):end) = [];

    % Rozmiar r w bajtach
    RLESize = numel(r);

    % Statystyka dla Huffmana
    rMax = max(r);
    rMin = min(r);

    % Histogram
    h = histc(r, rMin:rMax);

    % Obliczanie prawdopodobienstwa
    p = h ./ sum(h);

    % Tworzenie slownika Huffmana
    symbols = rMin:rMax; % Data symbols
    dict = huffmandict(symbols,p); % Create the dictionary.

    hcode = huffmanenco(r,dict); % Encode the data.

    codeSize = size(hcode);
    codeSize = codeSize(1);
    codeSize = (ceil(codeSize / 8));

    huffmanSize = codeSize;

