/*====================================================
  PROJECT: AIDS Clinical Trial Data Analysis using SAS
=====================================================*/

/* STEP 1: Import Dataset */

PROC IMPORT DATAFILE="/home/u64516120/AIDS_ClinicalTrial_GroupStudy175.csv"
    OUT=aids_data
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;


/* STEP 2: View Dataset Structure */

PROC CONTENTS DATA=aids_data;
RUN;


/* STEP 3: Display First 10 Observations */

PROC PRINT DATA=aids_data (OBS=10);
RUN;


/*====================================================
  DESCRIPTIVE STATISTICS
=====================================================*/

/* STEP 4: Summary Statistics */

PROC MEANS DATA=aids_data
    N MEAN STD MIN MAX;

    VAR age wtkg cd40 cd80;

RUN;


/*====================================================
  FREQUENCY DISTRIBUTION
=====================================================*/

/* STEP 5: Frequency Tables */

PROC FREQ DATA=aids_data;

TABLES gender trt label;

RUN;


/*====================================================
  ANOVA
=====================================================*/

/* STEP 6: Compare CD4 Count Between Treatment Groups */

PROC ANOVA DATA=aids_data;

CLASS trt;

MODEL cd40 = trt;

RUN;


/*====================================================
  CORRELATION ANALYSIS
=====================================================*/

/* STEP 7: Correlation Analysis */

PROC CORR DATA=aids_data;

VAR age wtkg cd40 cd80;

RUN;


/*====================================================
  LOGISTIC REGRESSION
=====================================================*/

/* STEP 8: Logistic Regression */

PROC LOGISTIC DATA=aids_data;

CLASS gender trt;

MODEL label(EVENT='1') =
      age wtkg cd40 cd80 trt;

RUN;


/*====================================================
  SURVIVAL ANALYSIS
=====================================================*/

/* STEP 9: Kaplan-Meier Survival Curve */

PROC LIFETEST DATA=aids_data
    PLOTS=SURVIVAL;

TIME time*label(0);

STRATA trt;

RUN;


/*====================================================
  COX PROPORTIONAL HAZARDS MODEL
=====================================================*/

/* STEP 10: Cox Regression */

PROC PHREG DATA=aids_data;

CLASS gender trt;

MODEL time*label(0) =
      age wtkg cd40 cd80 trt;

RUN;


/*====================================================
  DATA VISUALIZATION
=====================================================*/

/* STEP 11: Boxplot */

PROC SGPLOT DATA=aids_data;

VBOX cd40 / CATEGORY=trt;

TITLE "CD4 Count Across Treatment Groups";

RUN;


/* STEP 12: Scatter Plot */

PROC SGPLOT DATA=aids_data;

SCATTER X=age Y=cd40;

TITLE "Age vs CD4 Count";

RUN;