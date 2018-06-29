    function data = BIS(data)
%data = BIS(data)
%This function combines RTs and PC into a combined measure termed 'Balanced
  %Integration Score' (Liesefeld, Fu, & Zimmer, 2015, JEP:LMC, 41, 1140-1151;
  %Liesefeld & Janczyk, in press)
%the input data contains the field 'rt' and 'pc'
%the function calculates BIS with values standardized across all fields of the 
  %input and adds the field 'bis', which has the same format as 'rt' and 'pc'
if ~exist('data','var') || ~isstruct(data) 
    error('The input must be a struct containing the fields ''rts'' and ''pc'' (mean correct RTs and percent correct, respectively).')
end
if ~isfield(data,'rts') && isfield(data,'mean_rt_c')
    data.rts=data.mean_rt_c;
end
if  ~isfield(data,'rts') || ~isfield(data,'pc') || ~isnumeric(data.rts) || ~isnumeric(data.pc)
    error('The input must be a struct containing the fields ''rts'' and ''pc'' (mean correct RTs and percent correct, respectively).')
end
srt = std(data.rts(:),1); %sample standard deviation across all rts
spc = std(data.pc(:),1);  %sample standard deviation across all pc
mrt = mean(data.rts(:));  %mean across all rts
mpc = mean(data.pc(:));   %mean across all pcs
zrt = (data.rts-mrt)/srt; %z-standardized rts
zpc = (data.pc-mpc)/spc;  %z-standardized pcs
data.bis = zpc - zrt;     %Balanced Integration Score
end