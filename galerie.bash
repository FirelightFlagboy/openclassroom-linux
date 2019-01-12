# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    galerie.bash                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fbenneto <fbenneto@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/02/11 20:01:02 by fbenneto          #+#    #+#              #
#    Updated: 2018/02/11 23:03:34 by fbenneto         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SEP="************************************\n"
BEGIN="\n\tbegin\n\n"
END="\n\tend\n"
correct_exp="jpg jpeg png"
output_file_name="galerie.html"
dir=""

dbegin() {
	printf "$SEP"
	printf $BEGIN
}

dend() {
	printf $END
	printf "$SEP"
	exit $1
}

get_dir() {
	for arg in $*
	do
		if [ -d $arg ]
		then
			dir="$dir $arg"
		else
			printf "$arg is not a directory\n"
		fi
	done
}

html_init() {
	echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">" > $file
	echo "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"fr\" >" >> $file
	echo "	<head>" >> $file
	echo "		<title>Ma galerie</title>" >> $file
	echo "		<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />" >> $file
	echo "		<style type=\"text/css\"> a img { border:0; }</style>" >> $file
	echo "	</head>" >> $file 
	echo "	<body>" >> $file
	echo "		<p>" >> $file
}

html_populated() {
	for f in $ffile
	do
		echo "			<h3>file $f</h3>" >> $file
		echo "			<a href=\"$f\">" >> $file
		echo "				<img src=\"$f\" alt=\"\" />" >> $file
		echo "			</a>" >> $file
	done
}
html_end() {
	echo "		</p>" >> $file
	echo "	</body>" >> $file
	echo "</html>" >> $file
}

work_on_folder() {
	cd $1
	file=`ls`
	ffile=""
	for f in $file
	do
		if [ -f $f ]
		then
			for reg in $correct_exp
			do
				if [[ "$f" =~ ^.*\.$reg$ ]]
				then
					ffile="$ffile $f"
				fi
			done
		fi
	done
	echo $ffile
}

dbegin

if [ $# -eq 0 ]
then
	printf "error no directory given"
	dend 1
fi
get_dir $*

for d in $dir
do
	printf "\nworking on folder :$d\n"
	work_on_folder $d
	file="$d/$output_file_name"
	html_init
	html_populated 
	html_end
done

dend 0
