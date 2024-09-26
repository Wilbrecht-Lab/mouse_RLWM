Here is a brief description of the folders and files contained within this directory:


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
