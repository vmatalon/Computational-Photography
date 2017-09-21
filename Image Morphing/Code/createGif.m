function [] = createGif(frames,delay_time,num)
%CREATEGIF Creates a gif from the frames in frames with the delay time
%specified. 
%   The gif that will be created goes through the sequence of frames 
%   forward and backwards and the user specifies the delay time.

axis tight;
file_name = ['morph',num2str(num),'.gif'];

field_names = fieldnames(frames);
frame_count = length(field_names);
third_dimension = size(frames.(field_names{1}),3);

%Add sequence forward
for f = 1:frame_count
    frame = frames.(field_names{f});
    if third_dimension==3
    [A,map] = rgb2ind(frame,256);
    else 
        [A,map] = gray2ind(frame,256);
    end
    if f==1
        imwrite(A,map,file_name,'gif','LoopCount',frame_count*2,...
            'DelayTime',delay_time);
    else
        imwrite(A,map,file_name,'gif','WriteMode','append',...
            'DelayTime',delay_time);
    end
end

%Add sequence backwards
indices = sort(1:frame_count,'descend');
for f = 1:frame_count
    frame = frames.(field_names{indices(f)});
    if third_dimension==3
    [A,map] = rgb2ind(frame,256);
    else 
        [A,map] = gray2ind(frame,256);
    end
    imwrite(A,map,file_name,'gif','WriteMode','append',...
        'DelayTime',delay_time);
end

end

