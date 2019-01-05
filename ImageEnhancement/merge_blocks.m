function mergedBlks = merge_blocks(data)
%  merge_blocks accroding to the value
%
    s = size(data);
    mergedBlks = zeros((s(3) * s(1)), (s(4) * s(2)));

    %Merging the Blocks
    for i = 1 : s(3)
        for j = 1 : s(4)
            localBlk = data(:,:,i,j);
            rowStart = ((i - 1) * s(1)) + 1;
            rowEnd = i * s(1);
            colStart = ((j - 1) * s(2)) + 1;
            colEnd = j * s(2);
            mergedBlks(rowStart:rowEnd, colStart:colEnd) = localBlk;
        end
end