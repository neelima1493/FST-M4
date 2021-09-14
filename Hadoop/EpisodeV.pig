inputFile = LOAD 'hdfs:///user/root/inputs/episodeV_dialogues' USING PigStorage('\t') AS (name: chararray, line: chararray);

ranked = RANK inputFile;

onlyDialogues = FILTER ranked BY (rank_inputFile > 2);

groupByName = GROUP onlyDialogues BY name;

names = FOREACH groupByName GENERATE $0 AS name, COUNT($1) AS no_of_lines;

namesOrdered = ORDER names BY no_of_lines DESC;

STORE namesOrdered INTO 'hdfs:///user/root/outputs';