
% 定義WindowButtonMotionFcn事件處理函數
function mouseMoveCallback(~, ~)
    % 獲取當前的座標值
    point = get(gca, 'CurrentPoint');
    x = point(1, 1);
    y = point(1, 2);
    
    % 更新文字標籤的位置和內容
    set(textHandle, 'Position', [x, y, 0], 'String', sprintf('(%0.2f, %0.2f)', x, y));
end