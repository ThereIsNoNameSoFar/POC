% Tomasz Kryjak, Tomasz Pieciak
% Laboratorium Biocybernetyki AGH

% Proste obliczenie kompresji za pomoce RLE i kodowania Huffmana 

% Parametry
% Wejscie : 
%   - obraz - oryginalny obraz (przed DCT)
%   - obrazKwantyzacjaY - obraz po etapie kwantyzacji (skladowa Y)
%   - obrazKwantyzacjaCb - obraz po etapie kwantyzacji (skladowa Cb)
%   - obrazKwantyzacjaCr - obraz po etapie kwantyzacji (skladowa Cr)


% Wyjscie:
%   - oryginalSize  - rozmiar oryginalny     (w bajtach)
%   - RLESize       - rozmiar po RLE         (w bajtach)
%   - huffmanSize   - rozmiar po Huffmanie   (w bajtach)


function [oryginalSize RLESize huffmanSize ] = symbolEncoderYCbCr(obraz, obrazKwantyzacjaY, obrazKwantyzacjaCb, obrazKwantyzacjaCr  ) 

   [oY RLEY huffmanY ] = symbolEncoder(obraz, obrazKwantyzacjaY );
   [oCb RLECb huffmanCb ] = symbolEncoder(obraz, obrazKwantyzacjaCb );
   [oCr RLECr huffmanCr ] = symbolEncoder(obraz, obrazKwantyzacjaCr );
   
   oryginalSize =  oY + oCb + oCr;
   RLESize = RLEY + RLECb + RLECr;
   huffmanSize = huffmanY+ huffmanCb+huffmanCr;
