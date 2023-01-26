/******************************************************************/
/* 1.ýýýýýýýý¡¡¡¡ýWilcoxonýýýýý¡¡¡¡ýýý */
/******************************************************************/

proc import datafile="C:\Users\Lenovo\Desktop\data\data1.csv" out=data1 replace;
RUN;                                     /* ýýýýcsvýý¡¡ýýýýdata1¡¡data1 */
Data data1;
set data1;
Diff=weight-EDTA;                        /* ýýýýý¡ÀýýýDiff */
RUN;
PROC UNIVARIATE NORMAL;                /* ýýýýUNIVARIATEýýýý */
VAR Diff;                                /* ¡¡ýý¡¡ýýýýý¡¡ýýý¡¡Diff */
RUN;
/******************************************************************/
/* 2. ýýýýýýýýýýýýý¡¡¡¡ýWilcoxoný¡¡¡¡ýýý */
/******************************************************************/

proc import datafile="C:\Users\Lenovo\Desktop\data\data2.csv" out=data2 replace;
RUN;                                     /* ýýýýcsvýý¡¡ýýýýdata2¡¡data2 */
PROC UNIVARIATE NORMAL;                /* ýýýýUNIVARIATEýýýý */
CLASS drug;                              /* ¡¡ýýýýýýýýý¡¡drug */
var ratio;                               /* ýýýýýýý¡¡ýýýratioýýýý¡¡ýý */
RUN;
PROC  NPAR1WAY  WILCOXON;              /* ýýý¨´ýýýNPAR1WAYýýýýý¡¡¡¡ýýý */
VAR ratio;                               /* ¡¡ýý¡¡ýýýýý¡¡ýýý¡¡ratio */
CLASS drug;                              /* ¡¡ýýýýýýýýý¡¡drug */
exact;                                   /* §³ýýýý¡¡ýý¡¡ýýýýexact¡¡ýý¡¡ýýýýýýý¡¡ý¡¡ýý?*/
RUN;   
/******************************************************************/
/* 3. ýýýýýýýýýýýý¡¡¡¡ýKruskal-Wallis H ýýýý */
/******************************************************************/

proc import datafile="C:\Users\Lenovo\Desktop\data\data3.csv" out=data3 replace;
RUN;                                     /* ýýýýcsvýý¡¡ýýýýdata3¡¡data3 */
PROC  NPAR1WAY  WILCOXON;              /* ýýý¨´ýýýNPAR1WAYýýýýý¡¡¡¡ýýý */
CLASS group;                             /* ¡¡ýýýýýýýýý¡¡group */
VAR time;                                /* ¡¡ýý¡¡ýýýýý¡¡ýýý¡¡time */
exact;                                   /* §³ýýýý¡¡ýý¡¡ýýýýexact¡¡ýý¡¡ýýýýýýý¡¡ý¡¡ýý?*/
RUN;   
PROC  RANK  data=data3 out=a;           /* ²ÉÓÃ²ÎÊý·½·¨¶ÔÖÈ´Î½øÐÐ²ÎÊý·¨¶àÖØ±È½Ï */
VAR time;
RANKS r;
RUN;
PROC ANOVA data=a;
CLASS group;  
MODEL r=group;
/* MEANS group/lsd; */                   /* Bonferroni·¨ */
MEANS group/bon;                         /* lsd·¨ */
RUN;

/******************************************************************/
/* 4. ýýýýýýýýý¡¡ýýýýýýý¡¡¡¡ýFriedman M ýýýý */
/******************************************************************/

proc import datafile="C:\Users\Lenovo\Desktop\data\data4.csv" out=data4 replace;
RUN;                                      /* ýýýýcsvýý¡¡ýýýýdata4¡¡data4 */
PROC  FREQ;                              /* ýýý¨´ýýýNPAR1WAYýýýýý¡¡¡¡ýýý */
TABLES block*group*score/SCORES=RANK CMH2;/* ¡¡ýýýýýýýýý¡¡block */
exact;                                    /* §³ýýýý¡¡ýý¡¡ýýýýexact¡¡ýý¡¡ýýýýýýý¡¡ý¡¡ýý?*/
RUN;   
proc sort data=data4 out=a;              /* ²ÉÓÃ²ÎÊý·½·¨¶ÔÖÈ´Î½øÐÐ²ÎÊý·¨¶àÖØ±È½Ï */
by block ;
run;
proc rank data=a out=b;
var score;
by block;
ranks r ;
run;
proc glm data=b ;
class group block ;
model r = group block/ ss1 ;
lsmeans group/ stderr pdiff ;
run;

