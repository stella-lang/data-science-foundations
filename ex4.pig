-- ex4.pig

STATIONS = LOAD '/home/mlang10/Stat480/hb-workspace/input/ncdc/StationCodes.txt' AS (usaf: int, wban:int, location:chararray);
TEMPS = LOAD '/home/mlang10/Stat480/hb-workspace/input/ncdc/Data1910s.txt' AS (usaf:int, wban:int, year:chararray, temp:int);
RAW_MERGING = JOIN STATIONS by $0, TEMPS by $0;

/*RAW_MERGING table contains repeated data so I will remove these values*/
MERGING = FOREACH RAW_MERGING GENERATE $0,$1,$2,$5,$6;

/*Group by year*/
GROUPED = GROUP MERGING BY $2;

/*Create table range of temps for each station*/
MAXMIN = FOREACH GROUPED GENERATE group, MAX(MERGING.TEMPS::temp), MIN(MERGING.TEMPS::temp);
RANGES = FOREACH MAXMIN GENERATE group, $1-$2;

/*Get Station with the lowest range*/
ORDERED_RANGES = ORDER RANGES BY $1;
LOWEST = LIMIT ORDERED_RANGES 1;

/*Create table with only observations from the lowest range temperature station*/
RAW_LOWEST = JOIN LOWEST by $0, MERGING by STATIONS::location;
MY_LOWEST = FOREACH RAW_LOWEST GENERATE $0,$2,$3,$5,$6;

/*Group by Year and obtain result*/
YEAR = GROUP MY_LOWEST BY $3;
RESULT = FOREACH YEAR GENERATE group, MAX(MY_LOWEST.MERGING::TEMPS::temp)-MIN(MY_LOWEST.MERGING::TEMPS::temp),AVG(MY_LOWEST.MERGING::TEMPS::temp);

/*Store and Display Results*/
STORE RESULT INTO 'ex4Result';
DUMP RESULT;
