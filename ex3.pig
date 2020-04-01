-- ex3.pig

STATIONS = LOAD '/home/mlang10/Stat480/hb-workspace/input/ncdc/StationCodes.txt' AS (usaf: int, wban:int, location:chararray);
TEMPS = LOAD '/home/mlang10/Stat480/hb-workspace/input/ncdc/Data1910s.txt' AS (usaf:int, wban:int, year:chararray, temp:int);
RAW_MERGING = JOIN STATIONS by $0, TEMPS by $0;

/*RAW_MERGING table contains repeated data so I will remove these values*/
MERGING = FOREACH RAW_MERGING GENERATE $0,$1,$2,$5,$6;

/*Get only the records that are from RUSSARO */
RUSSARO = FILTER MERGING BY $2 == 'RUSSARO';

/*Group by year*/
YEAR = GROUP RUSSARO by TEMPS::year;

/*Generate the result*/
RESULT = FOREACH YEAR GENERATE group, MIN(RUSSARO.TEMPS::temp), MAX(RUSSARO.TEMPS::temp);

/*Store and print results*/
STORE RESULT INTO 'ex3Result';
DUMP RESULT;
