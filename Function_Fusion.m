%% Fusion Function: SONAR + LIDAR

function [Fusion] = Function_Fusion(Sonar, Lidar)
   dif = Sonar(1) - Lidar(1);
   if dif(1) > -7 && dif(1) < 7
       Fusion = (Sonar+Lidar) / 2;
   else
       if dif < -7
           Fusion = Sonar;
       end
       if dif > 7
           Fusion = Lidar;
       end
   end
end