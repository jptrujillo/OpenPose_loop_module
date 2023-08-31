#!/bin/bash
#this will go through all files with a .avi extension in the DIR path, renaming them to remove spaces, and then running the motion tracking
#The code is currently set to do body and hand tracking, saving keypoints (joint positions) as well as the tracked video.

DIR=videos_to_analyze/analyze_folder/
for file in "$DIR"*.avi
do
	file_new=$(sed 's/ /_/g' <<< "$file") #rename the file so there are no spaces, otherwise it won't run
	echo $file
	echo $file_new
	mv "$file" "$file_new"
	filename="${file_new##*/}" #strip the path, so we also just have the filename

	#set output folder and filenames
	output_json_folder="output/${filename}/"
	output_video_filename="${output_json_folder}video_track.avi"
	echo $output_video_filename
	mkdir $output_json_folder #make the output folder

	#run the analysis
	bin/OpenPoseDemo.exe --video $file_new  --write_json $output_json_folder --write_video $output_video_filename --net_resolution "320x176" 
done