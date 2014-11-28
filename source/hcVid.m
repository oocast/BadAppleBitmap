load('badapple.mat');
[dump nFrame] = size(mov);

% byte per frame
bpf = 44;
h = 16;
w = 22;

s = 1;
while sum(sum(mov(s).cdata)) == 0
    s = s + 1;
end
s = s - 5;


e = nFrame;
while sum(sum(mov(e).cdata)) == 0
    e = e - 1;
end
e = e + 4;


rawdata = uint8(zeros(bpf, e - s + 1));

for f = s:e
    k = f - s + 1;
    for x = 1:w
        bt = uint8(0);
        for y = 1:h
            data = mov(f).cdata(y,x);
            if data > 100
                bt = bt + bitshift(1, mod(y - 1,8));
            end
            if y == 8 || y == 16
                rawdata(ceil(((x-1)*16+y)/8),k) = bt;
                bt = uint8(0);
            end
        end
    end
end

for k = 1 : 4: nFrame
    imshow(mov(k).cdata);
%     pause(0.05);
end