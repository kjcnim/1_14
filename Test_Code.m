clear;
close all;
clc;

load('Test_Data.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 실제 차량용 FMCW 레이더 데이터 샘플
%%% 좌회전 : 10장, 우회전 : 10장
%%% 각 데이터는 크기가 127 x 51인 행렬
%%% 10 x 127 x 51 : Cube expression of processed radar signal.
%%% 적절한 픽셀 크기로 라벨링 -> YOLO 네트워크 설계 후 돌려보기
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
for ii = 1:2
    subplot(1, 2, 1) %subplot(m,n,p)는 현재 Figure를 mxn 그리드로 나누고, p로 지정된 위치에 좌표축을 만듭니다.
    
    % imagesc : 스케일링된 색으로 이미지 표시
    % squueze : 길이가 1인 차원을 제거한다. ^1.5는 해상도를 높여주는 역할을 한다.
    % 10 x 127 x 51 : Cube expression of processed radar signal.
    % 따라서 이 한 줄을 통해 각각의 숫자 데이터를 한 장의 사진으로 출력하는 것이다.
    % 10장의 이미지는 곧 높이가 10인 CUBE라고 생각하면 된다.
    % 따라서 첫번째 이미지는 높이가 1인 영역을 그렸을 때 이미지
    % 따라서 각 이미지에서 라벨링할 점에 대응되는 데이터값의 특징들을 보고 이에 맞는 함수를 적용시켜서 자동 라벨링 할 수 있도록 하면 된다. 
    imagesc(squeeze(left_turn_Data(ii, :, :).^1.5));
    
    xlabel('Distance (m)')
    ylabel('Angle (deg.)')
    
    [value,max_p] = max(left_turn_Data(ii,:));
    max_p_Distance = fix(max_p/127);
    max_p_Angle = max_p - (max_p_Distance * 127);
    
    box1_x = (max_p_Distance -2);
    box1_y = (max_p_Angle + 20);
    box_point_3 = 127 * (box1_x - 1) + box1_y;
    
    box2_x = (max_p_Distance - 2);  
    box2_y = (max_p_Angle - 13);
    box_point_1 = 127 * (box2_x - 1) + box2_y;
    
    box3_x = (max_p_Distance + 21);
    box3_y = (max_p_Angle - 13);
    box_point_2 = 127 * (box3_x - 1) + box3_y;
   
    box4_x = (max_p_Distance + 21);
    box4_y = (max_p_Angle + 20);
    box_point_4 = 127 * (box4_x - 1) + box4_y;
    
    X = [box1_x; box2_x; box3_x; box4_x];
    Y = [box1_y; box2_y; box3_y; box4_y];
  
    pgon = polyshape(X,Y)
    
    plot(pgon)
    
    subplot(1, 2, 2)
    imagesc(squeeze(right_turn_Data(ii, :, :).^1.5)); % 우회전
    B = imagesc(squeeze(right_turn_Data(ii, :, :).^1.5)); % 우회전
    xlabel('Distance (m)')
    ylabel('Angle (deg.)')
    
    box1_a = (max_p_Distance -2);
    box1_b = (max_p_Angle + 20);
    box_point_3 = 127 * (box1_a - 1) + box1_b;
    
    box2_a = (max_p_Distance - 2);  
    box2_b = (max_p_Angle - 13);
    box_point_1 = 127 * (box2_a - 1) + box2_b;
    
    box3_a = (max_p_Distance + 21);
    box3_b = (max_p_Angle - 13);
    box_point_2 = 127 * (box3_a - 1) + box3_b;
   
    box4_a = (max_p_Distance + 21);
    box4_b = (max_p_Angle + 20);
    box_point_4 = 127 * (box4_a - 1) + box4_b;
    
    A = [box1_a; box2_a; box3_a; box4_a];
    B = [box1_b; box2_b; box3_b; box4_b];
  
    pgon = polyshape(A,B)
    
    plot(pgon)
    
    pause(5);
    
end

%% 해야할 것
% 1. 데이터 값 축적
% 2. 이미지 데이터 위에 그리기
