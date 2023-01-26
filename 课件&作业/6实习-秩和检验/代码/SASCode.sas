/******************************************************************/
/* 1.�������������Wilcoxon������������ */
/******************************************************************/

proc import datafile="C:\Users\Lenovo\Desktop\data\data1.csv" out=data1 replace;
RUN;                                     /* ����csv��������data1��data1 */
Data data1;
set data1;
Diff=weight-EDTA;                        /* ����������Diff */
RUN;
PROC UNIVARIATE NORMAL;                /* ����UNIVARIATE���� */
VAR Diff;                                /* ������������������Diff */
RUN;
/******************************************************************/
/* 2. ������������������Wilcoxon�������� */
/******************************************************************/

proc import datafile="C:\Users\Lenovo\Desktop\data\data2.csv" out=data2 replace;
RUN;                                     /* ����csv��������data2��data2 */
PROC UNIVARIATE NORMAL;                /* ����UNIVARIATE���� */
CLASS drug;                              /* �������������drug */
var ratio;                               /* ������������ratio�������� */
RUN;
PROC  NPAR1WAY  WILCOXON;              /* ��������NPAR1WAY������������ */
VAR ratio;                               /* ������������������ratio */
CLASS drug;                              /* �������������drug */
exact;                                   /* ����������������exact��������������������?*/
RUN;   
/******************************************************************/
/* 3. �����������������Kruskal-Wallis H ���� */
/******************************************************************/

proc import datafile="C:\Users\Lenovo\Desktop\data\data3.csv" out=data3 replace;
RUN;                                     /* ����csv��������data3��data3 */
PROC  NPAR1WAY  WILCOXON;              /* ��������NPAR1WAY������������ */
CLASS group;                             /* �������������group */
VAR time;                                /* ������������������time */
exact;                                   /* ����������������exact��������������������?*/
RUN;   
PROC  RANK  data=data3 out=a;           /* ���ò����������ȴν��в��������رȽ� */
VAR time;
RANKS r;
RUN;
PROC ANOVA data=a;
CLASS group;  
MODEL r=group;
/* MEANS group/lsd; */                   /* Bonferroni�� */
MEANS group/bon;                         /* lsd�� */
RUN;

/******************************************************************/
/* 4. �����������������������Friedman M ���� */
/******************************************************************/

proc import datafile="C:\Users\Lenovo\Desktop\data\data4.csv" out=data4 replace;
RUN;                                      /* ����csv��������data4��data4 */
PROC  FREQ;                              /* ��������NPAR1WAY������������ */
TABLES block*group*score/SCORES=RANK CMH2;/* �������������block */
exact;                                    /* ����������������exact��������������������?*/
RUN;   
proc sort data=data4 out=a;              /* ���ò����������ȴν��в��������رȽ� */
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

