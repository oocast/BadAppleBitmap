xyloObj = VideoReader('BAD APPLE.mp4');

nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

s = 16 / vidHeight;
% Preallocate movie structure.
mov(1:nFrames) = ...
    struct('cdata', zeros(ceil(vidHeight * s), ceil(vidWidth * s), 1, 'uint8'),...
           'colormap', 'gray');

% Read one frame at a time.
for k = 1 : nFrames
    frame = read(xyloObj, k);
    frame = imresize(frame, s);
    frameg = rgb2gray(frame);
    mov(k).cdata = frameg;
end

% Size a figure based on the video's width and height.
% hf = figure;
% set(hf, 'position', [150 150 ceil(vidHeight * s) ceil(vidWidth * s)])

% Play back the movie once at the video's frame rate.
% movie(hf, mov, 1, xyloObj.FrameRate);
