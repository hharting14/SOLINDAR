%% Decoding Function: Data Conversion

function [AngleSC, LidarSC, SonarSC] = Decoding(valorADC)
    % Data type
    databytes = int8(valorADC);  
    
    % Sync
    start = find(databytes > 0,1);                        
    synceddata = databytes(start:end-mod((16-start),4)-1);
    synceddata = typecast(synceddata,'uint8');
    
    % Size of each block
    blocksize = length(synceddata)/4;                    
    byte1 = synceddata(1:4:end);
    byte2 = synceddata(2:4:end);
    byte3 = synceddata(3:4:end);
    byte4 = synceddata(4:4:end);
    
    % Creating masks to assign values
    mask_pos1(1:blocksize,1) = uint8(127);                
    mask_sonar1(1:blocksize,1) = uint8(127);
    mask_sonar2(1:blocksize,1) = uint8(96);
    mask_lidar1(1:blocksize,1) = uint8(31);
    mask_lidar2(1:blocksize,1) = uint8(127);
    
    % Assigning position (angle)
    AngleSC = bitand(byte1, mask_pos1);                   
    AngleSC = single(AngleSC);
    AngleSC = round(AngleSC,1);
    
    % Adding masks and assigning to Sonar and Lidar
    sonar1 = single(bitand(byte2, mask_sonar1));          
    sonar2 = single(bitand(byte3, mask_sonar2));
    lidar1 = single(bitand(byte3, mask_lidar1));
    lidar2 = single(bitand(byte4, mask_lidar2));
    SonarSC = sonar1*4 + sonar2/32;
    LidarSC = lidar1*128 + lidar2;
end
