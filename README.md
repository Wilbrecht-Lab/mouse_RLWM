# Adolescent and adult mice use both incremental reinforcement learning and short term memory when learning concurrent stimulus-action associations
### Abstract: 
Computational modeling has revealed that human research participants use both rapid working memory (WM) and incremental reinforcement learning (RL) (RL+WM) to solve a simple instrumental learning task, relying on WM when the number of stimuli is small and supplementing with RL when the number of stimuli exceeds WM capacity. Inspired by this work, we examined which learning systems and strategies are used by adolescent and adult mice when they first acquire a conditional associative learning task. In a version of the human RL+WM task translated for rodents, mice were required to associate odor stimuli (from a set of 2 or 4 odors) with a left or right port to receive reward. Using logistic regression and computational models to analyze the first 200 trials per odor, we determined that mice used both incremental RL and stimulus- insensitive, one-back strategies to solve the task. While these one-back strategies may be a simple form of short-term or working memory, they did not approximate the boost to learning performance that has been observed in human participants using WM in a comparable task. Adolescent and adult mice also showed comparable performance, with no change in learning rate or softmax beta parameters with adolescent development and task experience. However, reliance on a one-back perseverative, win-stay strategy increased with development in males in both odor set sizes, but was not dependent on gonadal hormones. Our findings advance a simple conditional associative learning task and new models to enable the isolation and quantification of reinforcement learning alongside other strategies mice use while learning to associate stimuli with rewards within a single behavioral session. These data and methods can inform and aid comparative study of reinforcement learning across species.  
pre-print: https://www.biorxiv.org/content/10.1101/2024.04.29.591768v1
<br />
  



### Below is a brief description of the folders and files contained within this directory:  
# Data

- **raw_data**: contains all mouse session behavioral data.
- **processed_data**: contains all mouse session behavioral data, following logistic regression analysis and modeling.
- **sim_data**: simulated mouse session behavioral data, used for parameter and model recovery.

## raw_data
This repository contains six MATLAB `.mat` files, each representing datasets from behavioral experiments involving male subjects under various experimental conditions.

### file structure

Each `.mat` file contains a primary data structure with each row in each field corresponding to a single session. There are 8 total fields:

- **s**: Trial by trial odor schedule arrays (see t for more information)
- **a**: Trial by trial action arrays (lower number in pair corresponds to L choice, e.g. 1: L, 2: R)
- **r**: Trial by trial reward arrays (0 = no reward, 1 = reward)
- **rt**: Response or reaction time arrays recorded for each trial determined by inter-trial-interval
- **t**: Used to calibrate the L/R schedule size (3,6,8 = 1 or L side; 4,5,7 = 2 or R side)
- **animal**: Mouse identifiers, stored as strings (e.g., 'A2A-2BWT-NN'), representing different subjects in the study
- **age**: Mouse ages at the time of each session
- **correction**: Each session contained a program correction that would

## processed_data
This repository contains 2 `.csv` files that include a subset of sessions for each animal. Each session is a row, similar to raw_data, and columns include regression coefficients for regressions 1-3 and our winning model (s2 refers to s2=s4)

### file structure for *"all_age"* .csv files

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

### file structure for *"fig_2a"* .csv file
File tabs correspond to male/female mice from either set size = 2 (sz2) or set size = 4 (sz4). They are either binned for "uni_stim," meaning that each column corresponds to the fraction correct from 25 single stimulus presentations or averaged together following binning by odor. In "uni_stim" tabs every 2 rows correspond to a single session for a single animal (every 4 for sz4) and in each "avg" tab, every individual row corresponds to a single session. The data from the "avg" tabs were lifted and placed in GraphPad Prism for visualization and analysis. 

### file structure for *"model comparison"* file
Summary table of AIC/BIC/AICc/CAIC for 6 regressions for each session run for both males and females in set size = 2. 

## sim_data
For each sex and set size (and for gdx animals) there is a .mat file that contains three variables for the winning model with each row corresponding to a single session:
  - **Xfit_a0bs1232**: variable containing 5 columns that correspond to the 5 simulated parameters from winning model: alpha+, beta, s1, s2=s4, s3
  - **ll_a0bs1232**: log likelihood number for each individual session
  - **idx_a0bs1232**: animal identity 


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

# Analysis_code

This folder contains python scripts that were used for Figures 4,5,7-9 in the main text and Figures 5-6 in the supplement. It also contains the code used to run mixed linear models to produce the stats reported in the main text. In order to run the script, you must have downloaded *`all_age_regression.csv`* from the **processed_data** folder in **data**. 

# Modeling

## Fit and Likelihood folders
In each of these folders there are 8 scripts that correspond to 8 total models that we compared for fit in AIC/BIC with additional analayses of how frequent a model was used in a single session and protected exceedence probability. See Figure 6 in the main text for additional context and Material and Methods in the paper for equationos. Both folders contain 8 separate files that are named for each of the models, described below: 
  - **a0b**: a simple RL model with a single alpha positive learning rate (alpha negative learning rate is fixed at 0), and decision noise parameter beta. Corresponds to *no s* in Figure 6.
  - **a0bs**: same as above, but now with a single strategy parameter, s1. Corresponds to *s* in Figure 6.
  - **a0bs24**: same as *a0b* but now with two strategy parameters, s2 and s4. Corresponds to *s24* in Figure 6.
  - **a0bs124**: same as *a0b* but now with three strategy parameters: s1, s2, and s4. Corresponds to *s124* in Figure 6.
  - **a0bs234**: same as *a0b* but now with three strategy parameters, in a different configuration then above: s2, s3, and s4. Corresponds to *s234* in Figure 6.
  - **a0bs1234**: same *a0b* but now with all four strategy parameters: s1, s2, s3, and s4. Corresponds to *s1234* in Figure 6.
  - **a0bs1232**: same *a0b* but now, following correlation analysis, s2==s4 and there are three strategy parameters: s1,s2=s4,s3. Corresponds to *s1232* in Figure 6. This is our winning model.
  - **aabs1232**: same as *a0bs1232* but instead of alpha negative fixed at 0, there are two alpha learning parameters corresponding to learning from both positive and negative outcomes. Corresponds to *aa* in Figure 6.

## Model comparison folder
This folder contains multiple MATLAB scripts for model validation and comparison. All scripts require raw MATLAB data (e.g., `data_male_ns2.mat`) as well as the corresponding maximum likelihood .mat file
  - **generate_recover**: this script is for generate recover of mice data. The number of iterations should be set to include the number of sessions in the data set
  - **reg_compare**: compares regression results from mouse data with simulated data (barplots)
  - **sess_reg_compare**: compares regression results from mouse data with simulated data (scatterplots). Should be run with *reg_compare*.
  - **ModelValidation**: creates a learning curve binned by 25 trials for the winning model only using *online_simulation_compare_binned.m* 
  - **online_simulation_compare_binned.m**: function that bins data by 25 trials per odor and compares to simulated mouse data. num_trial describes the number of bins (25 trials per odor stim) and can be adjusted. We chose 8 (200 presentations of each odor stimulation) for our data analysis.

## Helpers
This folder contains helper functions in order to run other scripts
