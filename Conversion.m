%% Conversion Function: Sonar and Lidar

function [Angle,Lidar,Sonar] = Conversion(AngleSC,LidarSC, SonarSC)
   % Conversion Angle
    Steps = 96;                                          
    PositionScale = (2 * pi()/Steps);
    Angle = round(PositionScale * AngleSC,2);  
    
    % Conversión Lidar
    LidarPol = [7.67526029129288 -108.134109245746 644.115225669854 -2113.71833279663 4175.24292278666 -5097.1909611203 3802.7451305835 -1649.81901283364 366.038219660162];
    LidarScale = (3 / 4096) / 1.5;
    LidarEval = polyval(LidarPol, LidarScale * LidarSC);
    Lidar = round(LidarEval,2);
    Lidar = Lidar - 25;
    
    % Conversion Sonar
    Sonar = SonarSC * 4.74;
end