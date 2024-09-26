function [age_first_sess, sess_num] = age_sess(data)
% Extract the age of first session for each animal and session number for
% each session 

age_first_sess = nan(num_sess, 1);
sess_num = nan(num_sess, 1); % per mice

for sess = 1:num_sess
    animal = data.animal{sess};
    animal_all_sess_idx = find(strcmp(data.animal, animal) == 1);
    animal_first_sess_idx = animal_all_sess_idx(1);
    age_first_sess(sess) = data.age(animal_first_sess_idx); % get the age of the animal on its first session
    
    sess_num(sess) = find(animal_all_sess_idx == sess); % get the session number (wrt all the sessions the animal completed)
end

end

