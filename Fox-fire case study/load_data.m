%% LOAD DATA - FOX-FIRE CASE STUDY

% INPUT DATA & PRIOR PROB OF DECLINE
% Threat 1 = Foxes (m10)
    % management is baiting
% Threat 2 = Fires (m01)
    % management is reducing fire frequency (except for sp 3)

% Isoodon obesulus (southern brown bandicoot): Sp 1
% s1_m00 = 0.9; 
    % not used becasue we can estimate it as 1-m10-m01-m11.
    % Calculated value differs from data value. This is probably because
    % the threats are not independent and the calculation method asumes
    % independence. This is true for all species in the dataset.
s1_m10 = 0.1400952;
s1_m01 = 0.547558738;
s1_m11 = 0.124641227;

s1q = s1_m11;
s1_d1 = (s1_m01 - s1q)/(1 - s1q);
s1_d2 = (s1_m10 - s1q)/(1 - s1q);


% Trichosurus vulpecula vulpecula (western brushtail possum : Sp 2
% s2_m00 = 0.6186509;
s2_m10 = 0.2076965;
s2_m01 = 0.1662283;
s2_m11 = 0.0030352;

s2q = s2_m11;
s2_d1 = (s2_m01 - s2q)/(1 - s2q);
s2_d2 = (s2_m10 - s2q)/(1 - s2q);


% Macropus eugenii (tammar wallaby): Sp 3
    % Original data
s3_m01 = 0.9888956; 
s3_m11 = 0.707405;
s3_m00 = 0.9605787;
s3_m10 = 0.230124;    
    
s3q = s3_m10;
s3_d1 = (s3_m00 - s3q)/(1 - s3q);
s3_d2 = (s3_m11 - s3q)/(1 - s3q);


% COSTS ($/yr)
%   average expected cost per year ($M/yr)   
real_c1 = 10209.72;
real_c2 = 22951.62;

