# The following codes are from "Chapter2CodeSegments.sh" in class
# We can get more data by using a script.
# First change directory to where we want to store the additional data
cd ~/Stat480/hb-workspace/input/ncdc

# The weather period we are interested in is from 1901 to 1910.
./ncdc_data.sh 1910 1919

# We now need to put the files on HDFS.
hadoop fs -put ~/Stat480/hb-workspace/input/ncdc/all/* input/ncdc/all

# We can see that the files have been copied to the distributed file system.
hadoop fs -ls input/ncdc/all

# Create new directory "HW5" to store python codes
cd ~/Stat480/hb-workspace
mkdir HW5

# Exercise 1

# Python Streaming on all data files (1910-1919) without a combiner
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
  -files /home/mlang10/Stat480/hb-workspace/HW5/min_temp_map.py,\
/home/mlang10/Stat480/hb-workspace/HW5/min_temp_reduce.py \
  -input input/ncdc/all \
  -output output/ex1 \
  -mapper "/home/mlang10/Stat480/hb-workspace/HW5/min_temp_map.py" \
  -reducer "/home/mlang10/Stat480/hb-workspace/HW5/min_temp_reduce.py"
# See result files.
hadoop fs -ls output/ex1

# View results.
hadoop fs -cat output/ex1/part*

# Exercise 2

hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
  -files /home/mlang10/Stat480/hb-workspace/HW5/trusted_map.py,\
/home/mlang10/Stat480/hb-workspace/HW5/trusted_reduce.py \
  -input input/ncdc/all \
  -output output/ex2 \
  -mapper "/home/mlang10/Stat480/hb-workspace/HW5/trusted_map.py" \
  -reducer "/home/mlang10/Stat480/hb-workspace/HW5/trusted_reduce.py"
# See result files.
hadoop fs -ls output/ex2

# View results.
hadoop fs -cat output/ex2/part*

# Exercise 3

hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
  -files /home/mlang10/Stat480/hb-workspace/HW5/count_map.py,\
/home/mlang10/Stat480/hb-workspace/HW5/count_reduce.py \
  -input input/ncdc/all \
  -output output/ex3 \
  -mapper "/home/mlang10/Stat480/hb-workspace/HW5/count_map.py" \
  -reducer "/home/mlang10/Stat480/hb-workspace/HW5/count_reduce.py"
# See result files.
hadoop fs -ls output/ex3

# View results.
hadoop fs -cat output/ex3/part*


# Exercise 4
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
  -files /home/mlang10/Stat480/hb-workspace/HW5/mean_temp_map.py,\
/home/mlang10/Stat480/hb-workspace/HW5/mean_temp_reduce.py \
  -input input/ncdc/all \
  -output output/ex4 \
  -mapper "/home/mlang10/Stat480/hb-workspace/HW5/mean_temp_map.py" \
  -reducer "/home/mlang10/Stat480/hb-workspace/HW5/mean_temp_reduce.py"

# See result files.
hadoop fs -ls output/ex4

# View results.
hadoop fs -cat output/ex4/part*
