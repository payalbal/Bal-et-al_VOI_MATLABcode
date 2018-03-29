%% LOAD DATA FOR PILBARA CASE STUDY - FORTESCUE SUBREGION

% Input data includes the following:
%   1. Prior probability of extinction of species j under management of threat i
%   2. Prior probability of threat i causing extinction n species j
%   3. Cost of managing threats
% 
% Threat 1 = Grazing (m10 = managemnt of threat 1 NOT threat 2)
    % management is ...
% Threat 2 = Fire (m01 = managmenet of threat 2 NOT threat 1)
    % management is ...

    
% Macrotis lagotis (greater bilby): Sp 1
% s1_m00 = ...; 
    % not used becasue we can estimate it as 1-m10-m01-m11.
    % Calculated value differs from data value. This is probably because
    % the threats are not independent and the calculation method asumes
    % independence. This is true for all species in the dataset.
s1_m10 = 0.44125;
s1_m01 = 0.353333333;
s1_m11 = 0.271666667;
 
s1q = s1_m11;
s1_d1 = (s1_m01 - s1q)/(1 - s1q);
s1_d2 = (s1_m10 - s1q)/(1 - s1q);


% Dasyurus hallucatus (northern quoll): Sp 2
% s2_m00 = 0.6186509;
s2_m10 = 0.35;
s2_m01 = 0.245;
s2_m11 = 0.19;

s2q = s2_m11;
s2_d1 = (s2_m01 - s2q)/(1 - s2q);
s2_d2 = (s2_m10 - s2q)/(1 - s2q);


% Rattus tunneyi (pale field-rat): Sp 3
    % Original data
s3_m10 = 0.6;    
s3_m01 = 0.525; 
s3_m11 = 0.475;
    
s3q = s3_m11;
s3_d1 = (s3_m01 - s3q)/(1 - s3q);
s3_d2 = (s3_m10 - s3q)/(1 - s3q);


% COSTS
%   average expected cost per year ($M/yr)
real_c1 = 1.492677991;
real_c2 = 2.680494405;

