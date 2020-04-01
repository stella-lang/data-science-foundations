-- ex1.pig

RAW_STATIONS = LOAD '/home/mlang10/Stat480/hb-workspace/input/ncdc/StationCodes.txt' AS (usaf: int, wban:int, location:chararray);
RAW_TEMPS = LOAD '/home/mlang10/Stat480/hb-workspace/input/ncdc/Data1910s.txt' AS (usaf:int, wban:int, year:chararray, temp:int);
RAW_MERGING = JOIN RAW_STATIONS by $0, RAW_TEMPS by $0;

/*RAW_MERGING table contains repeated data so I will remove these values*/
MERGING = FOREACH RAW_MERGING GENERATE $0,$1,$2,$5,$6;

RESULT = LIMIT MERGING 5;

/*Store and print results*/
STORE RESULT INTO 'ex1Result';
DUMP RESULT;
