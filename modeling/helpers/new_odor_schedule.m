function [Schedule, varargout ]=new_odor_schedule(set_size)
% Generate a new odor schedule base on set_size (2 or 4 or 6)
% Schedule = new_odor_schedule(set_size)
% [Schedule,Port_Side ]= new_odor_schedule(set_size);

a=clock;
rand('state', ceil(a(end)));

CountedTrial = 0;
MaxTrial = 1500;
same_side_limit=3;
Schedule     = zeros(1,MaxTrial);
Port_Side    = zeros(1,MaxTrial);

% StimParam   = GetParam(me,'StimParam');
% param_string=GetParam(me,'StimParam','user');
% OdrCh_List=str2double(StimParam(:,strcmp(param_string,'Dout Channel')));
% OdrNm_List=StimParam(:,strcmp(param_string,'Odor Name'));
% vpled_List=StimParam(:,strcmp(param_string,'VP LED cue'));

% Ratio_cell = StimParam(:,strcmp(param_string,'stimulus probability'));
% Ratio=zeros(1,length(Ratio_cell));
% for i=1:length(Ratio_cell)
%     Ratio(i)=str2double(Ratio_cell{i});
% end
if set_size==2
    Ratio=[0 0 1 1 0 0 0 0];
elseif set_size==4
    Ratio=[0 0 1 1 1 1 0 0];
elseif set_size==6
    Ratio=[0 0 1 1 1 1 1 1];
else
    Schedule=[];
    disp('set_size not used');
end
Ratio=Ratio/sum(Ratio);


Cum_Ratio =[0 cumsum(Ratio)/sum(Ratio)];

last_port_side=0;
same_side_cont=0;

% LeftRewardP  =str2double(StimParam(:,strcmp(param_string,'left reward ratio')));
% RightRewardP =str2double(StimParam(:,strcmp(param_string,'right reward ratio')));
% if (2^(-same_side_limit))> min(Ratio*[RightRewardP LeftRewardP])
%     disp('same side limit will NOT be applied');
% end
LeftRewardP = [0 0 1 0 0 1 0 1]';
RightRewardP= [0 0 0 1 1 0 1 0]';
for i = CountedTrial+1 : MaxTrial
    random_num = rand;
    for j = 1:length(Ratio)
        if Cum_Ratio(j) <= random_num && random_num < Cum_Ratio(j+1)
            chan=j;
        break
        end
    end

    if sum([RightRewardP(chan) LeftRewardP(chan)])>1
        LeftRewardP(chan)  =LeftRewardP(chan)/sum([RightRewardP(chan) LeftRewardP(chan)]);
        RightRewardP(chan) =RightRewardP(chan)/sum([RightRewardP(chan) LeftRewardP(chan)]);
    end
    Cum_RewardP  =[0 cumsum([RightRewardP(chan) LeftRewardP(chan)])];
    random_num = rand;
    Port_Side(i)=0; %no reward
    if random_num < Cum_RewardP(3)
        for j = 1:2
            if Cum_RewardP(j) <= random_num && random_num < Cum_RewardP(j+1)
                Port_Side(i)=j;
            break
            end
        end
    end

    if last_port_side==Port_Side(i)
        same_side_cont=same_side_cont+1;
    else
        same_side_cont=0;
    end
    while (same_side_cont+1 > same_side_limit)&& (2^(-same_side_limit))<min(Ratio*[RightRewardP LeftRewardP])
        random_num = rand;
        for j = 1:length(Ratio)
            if Cum_Ratio(j) <= random_num && random_num < Cum_Ratio(j+1)
                chan=j;
            break
            end
        end
        if sum([RightRewardP(chan) LeftRewardP(chan)])>1
            LeftRewardP(chan)  =LeftRewardP(chan)/sum([RightRewardP(chan) LeftRewardP(chan)]);
            RightRewardP(chan) =RightRewardP(chan)/sum([RightRewardP(chan) LeftRewardP(chan)]);
        end
        Cum_RewardP  =[0 cumsum([RightRewardP(chan) LeftRewardP(chan)])];
        random_num = rand;
        Port_Side(i)=0;
        if random_num < Cum_RewardP(3)
            for j = 1:2
                if Cum_RewardP(j) <= random_num && random_num < Cum_RewardP(j+1)
                    Port_Side(i)=j;
                break
                end
            end
        end
        if last_port_side==Port_Side(i)
            same_side_cont=same_side_cont+1;
        else
            same_side_cont=0;
        end
        if same_side_cont > MaxTrial
            disp('SameSideLimit ignored','error');
            same_side_limit=inf;
        end
    end
    Schedule(i)=chan;
    last_port_side=Port_Side(i);
end

varargout{1}=Port_Side;




