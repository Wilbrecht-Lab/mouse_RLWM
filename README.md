# Adolescent and adult mice use both incremental reinforcement learning and short term memory when learning concurrent stimulus-action associations
### Abstract: 
Computational modeling has revealed that human research participants use both rapid working memory (WM) and incremental reinforcement learning (RL) (RL+WM) to solve a simple instrumental learning task, relying on WM when the number of stimuli is small and supplementing with RL when the number of stimuli exceeds WM capacity. Inspired by this work, we examined which learning systems and strategies are used by adolescent and adult mice when they first acquire a conditional associative learning task. In a version of the human RL+WM task translated for rodents, mice were required to associate odor stimuli (from a set of 2 or 4 odors) with a left or right port to receive reward. Using logistic regression and computational models to analyze the first 200 trials per odor, we determined that mice used both incremental RL and stimulus- insensitive, one-back strategies to solve the task. While these one-back strategies may be a simple form of short-term or working memory, they did not approximate the boost to learning performance that has been observed in human participants using WM in a comparable task. Adolescent and adult mice also showed comparable performance, with no change in learning rate or softmax beta parameters with adolescent development and task experience. However, reliance on a one-back perseverative, win-stay strategy increased with development in males in both odor set sizes. Our findings advance a simple conditional associative learning task and new models to enable the isolation and quantification of reinforcement learning alongside other strategies mice use while learning to associate stimuli with rewards within a single behavioral session. These data and methods can inform and aid comparative study of reinforcement learning across species.  <br />
  



### Below is a brief description of the folders and files contained within this directory:  
# Data

- **raw_data**: contains all mouse session behavioral data.
- **processed_data**: contains all mouse session behavioral data, following logistic regression analysis and modeling.
- **sim_data**: simulated mouse session behavioral data, used for parameter and model recovery.

## raw_data
This repository contains six MATLAB `.mat` files, each representing datasets from behavioral experiments involving male subjects under various experimental conditions.

### file structure

Each `.mat` file contains a primary data structure with each row in each field corresponding to a single session. There are 8 total fields:

- **s**: Trial by trial odor schedule arrays (lower number in pair corresponds to L choice, e.g. 1: L, 2: R)
- **a**: Trial by trial action arrays (lower number in pair corresponds to L choice, e.g. 1: L, 2: R)
- **r**: Trial by trial reward arrays (0 = no reward, 1 = reward)
- **rt**: Response or reaction time arrays recorded for each trial determined by inter-trial-interval
- **t**: Used to calculate the number of stimuli
- **animal**: Mouse identifiers, stored as strings (e.g., 'A2A-2BWT-NN'), representing different subjects in the study
- **age**: Mouse ages at the time of each session
- **correction**: Each session contained a program correction that would

## processed_data
This repository contains 2 `.csv` files that include a subset of sessions for each animal. Each session is a row, similar to raw_data, and columns include regression coefficients for regressions 1-3 and our winning model (s2 refers to s2=s4)

### file structure

1. Session Identifiers:
    - **animal_idx**: Unique identifier for each animal
    - **age**: Animal age for session
    - **age_first_sess**: Animal age for first session
    - **sess_num**: Session number
    - **perf**: Total performance (fraction correct) for the session (average of all stimuli together)
    - **sex**: Animal sex
    - **ns**: Number of stimuli (1: set size = 2; 2: set size = 4).

2. Regression Coefficients:
    - all start with *reg_* and correspond to the first 3 regressions. Reg #1: *reg_trial*; Reg #2: *reg_repeat*; Reg #3: *reg_reward*.
   
3. Modeling Parameters
    - **alpha_positive**: RL learning rate
    - **beta**: inverse temperature parameter
    - **s1**: strategy parameter 1, *"Inappropriate Lose-Shift"*
    - **s2**: strategy parameter 2=4, *"Stimulus Insensitive Win Stay"*
    - **s3**: strategy parameter 3, *"Inappropriate Lose-Stay"*

# Regression 
This folder contains MATLAB code for running 6 logistic regression analyses and in order to derive the coefficients found in the processed data. 

1. Regressions:
   - **trial_back_reg**: Regression #1
   - **repeat_nrepeat_common_reg**: Regression #2 (tied for AIC/BIC, regression presented in supplemental)
   - **reward_nreward_common_reg**: Regression #3 (tied for AIC/BIC, regression presented in main text)
   - **repeat_reward_reg**: Regression #4
   - **repeat_reward_interaction_reg**: Regression #5
   - **reward_repeat_nrepeat_common_reg**: Regression #6
All data from running regressions that was used for model comparison (AIC/BIC/AICc/CAIC) can be found in /data/processed_data
