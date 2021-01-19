clear;
close all;
clc;

load('Test_Data.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 실제 차량용 FMCW 레이더 데이터 샘플
%%% 좌회전 : 10장, 우회전 : 10장
%%% 각 데이터는 크기가 127 x 51인 행렬
%%% 적절한 픽셀 크기로 라벨링 -> YOLO 네트워크 설계 후 돌려보기
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
for ii = 1:10
    subplot(1, 2, 1) %subplot(m,n,p)는 현재 Figure를 mxn 그리드로 나누고, p로 지정된 위치에 좌표축을 만듭니다.
    imagesc(squeeze(left_turn_Data(ii, :, :).^1.5)); % 좌회전 차량
    xlabel('Distance (m)')
    ylabel('Angle (deg.)')
    
    subplot(1, 2, 2)
    imagesc(squeeze(right_turn_Data(ii, :, :).^1.5)); % 우회전
    xlabel('Distance (m)')
    ylabel('Angle (deg.)')
    
    pause(0.5);
end
