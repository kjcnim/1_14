%%% 이 코드는 점을 찍어 사각형을 그릴때, 직사각형을 그리도록 2개의 점만 선택하면 직사각형을 만드는 코드이다.

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

    %행렬 초기화
    L = int16.empty(0,4)
    L_A = int16.empty(0,4)
    
    R = int16.empty(0,4)
    R_A = int16.empty(0,4)
    
figure(1)    
for ii = 1:10
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
    
    % 점을 찍는 순서는 왼쪽 위, 오른쪽 아래
    [X,Y] = ginput(2);
    
    L(1,1) = X(1,1) % X좌표
    L(1,2) = Y(1,1) % Y좌표
    L(1,3) = X(2,1) - X(1,1) % 너비
    L(1,4) = Y(2,1) - Y(1,1) % 높이 
    
    L_A = [L_A; L];
    
    subplot(1, 2, 2)
    imagesc(squeeze(right_turn_Data(ii, :, :).^1.5)); % 우회전
    xlabel('Distance (m)')
    ylabel('Angle (deg.)')
   
    [A,B] = ginput(2);
    
    R(1,1) = A(1,1) % X좌표
    R(1,2) = B(1,1) % Y좌표
    R(1,3) = A(2,1) - A(1,1) % 너비
    R(1,4) = B(2,1) - B(1,1) % 높이

    R_A = [R_A; R];
    
end

LEFT = cell(10,1)
RIGHT = cell(10,1)

for ii = 1:10
    LEFT{ii,1} = L_A(ii, :)
    RIGHT{ii,1} = R_A(ii, :)
end

T = table(LEFT,RIGHT);
