load('rawdata.mat');

fid = fopen('anime.h', 'at+');


D = dir('./anime.h');
fsz = D.bytes;
if fsz == 0
    header1 = '#ifndef __ANIME_H__\r\n';
    fprintf(fid, header1);
    header1 = '#define __ANIME_H__\r\n';
    fprintf(fid, header1);
    header1 = '#include <avr/pgmspace.h>\r\n\r\n';
    fprintf(fid, header1);
    fprintf(fid, 'static const uint8_t PROGMEM badapple[] = \n{\n\t');
end

[nb nf] = size(rawdata);

r = 4; % compression rate

for f = 1:r:nf
    for b = 1:nb
        s = sprintf('0x%s, ',dec2hex(rawdata(b,f),2));
        fprintf(fid,'%s',s);
    end
    fprintf(fid,'\n\t');
end
fprintf(fid, '\n};\n');

bot = '#endif //__ANIME_H__\r\n';
fprintf(fid, bot);
fclose(fid);