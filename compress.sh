#Compression script.  Must enter the full path of the folder you want to compress starting from /home/...


IFS=$'\n'

cd $1


for file in $(ls)
do
	if [ -d $file ]
	then
		echo "$file is a folder!"
		if [  $file != "Compressed" -a $file != "Best" -a $file != "JPEGs" -a $file != "Edited" ]
		then
			echo Entering folder
			cd /home/kevinjen/Documents
			echo
			echo
			echo
			$0 $1/$file
		else
			echo Already in a folder of compressed items
		fi
	else 
		if [ ${file: -4} == ".MOV" -o ${file: -4} == ".MTS" ]
		then
			if [ ! -d "Compressed" ];
			then
				echo Compressed directory does not exist...creating
				mkdir Compressed
			fi

			echo ${file%.*} is a video...compressing with ffmpeg to H.264
			echo Output file ./Compressed/${file%.*}.mp4
			avconv -i $file -codec:v libx264 -b:v 5000000 -codec:a libmp3lame -b:a 128000 ./Compressed/${file%.*}.mp4
		fi

		if [ ${file: -4} == ".JPG" -o ${file: -4} == ".CR2" -o ${file: -4} == ".jpg" ]
		then
			if [ ! -d "Compressed" ];
			then
				echo Compressed directory does not exist...creating
				mkdir Compressed
			fi

			echo ${file%.*} is a photo...compressing
			echo Output file ./Compressed/${file%.*}.jpg
			convert $file -quality 80 ./Compressed/${file%.*}.jpg
		fi

	fi
	cd $1
done

echo
echo
echo
