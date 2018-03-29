% % FILENAME: get_samp_postprob
% % TYPE: function
% % AUTHORS: Payal Bal
% 
% % DESCRIPTION: function to calculate probability of obtaining sample
% % information, x, given the model. This is used in the estimation of EVSI.
% 
% 
% % INPUTS:
% % models = set of models
% % sample_x = sample information; can either be 0 or 1 i.e. 'x' information
% %   from monitoring species j
% % sp_monit = specifies which species is monitored by giving the index of
% %   column (i.e index of species) from a 2-threat x 3-species
% %   matrix for a specific model i.e. j
% 
% 
% % OUTPUTS:
% % output = posterior probability of sample information, x



% % WITHOUT ERRORS - COMMENT FOR ERROR ANALYSIS
function [output] = get_samp_postprob(models, q, sample_x, sp_monit)
    output = NaN([1,size(models,1)]);

    for i = 1:size(models,1)
        mod = models(i,:);
        mod = [mod(1:3);mod(4:6)];
        %converts vector into a 2 threat x 3 species matrix
        
        calc = max(mod(:,sp_monit));

        if sample_x == 1
            output(1,i) = q(sp_monit) + (1 - q(sp_monit)) * calc;
    
        elseif sample_x == 0
            output(1,i) = 1-(q(sp_monit) + (1 - q(sp_monit)) * (calc));
            
        end
        
    end
end
    


% % WITH ERRORS - UNCOMMENT FOR ERROR ANALYSIS
% function [output] = get_samp_postprob(models, q, sample_x, sp_monit)
% 
% global type1 type2
%     % type1 = alpha (Type I error)
%     % type2 = beta (Type II error)
% 
%     output = NaN([1,size(models,1)]);
% 
%     for i = 1:size(models,1);
%         mod = models(i,:);
%         mod = [mod(1:3);mod(4:6)];
%         %converts vector into a 2 threat x 3 species matrix
%         
%         calc = max(mod(:,sp_monit));
% 
%         if sample_x == 1
%             output(1,i) = ((q(sp_monit) + (1 - q(sp_monit)) * calc) * (1 - type2))...
%                 + ((1-(q(sp_monit) + (1 - q(sp_monit)) * (calc))) * type1);
%     
%         elseif sample_x == 0
%             output(1,i) = ((q(sp_monit) + (1 - q(sp_monit)) * calc) * type2)...
%                 + ((1-(q(sp_monit) + (1 - q(sp_monit)) * (calc))) * (1 - type1));
%             
%         end
%         
%     end
%     
% end


