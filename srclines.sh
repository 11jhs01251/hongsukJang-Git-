# usage  : srcline.sh <target_dir>
#        : srcline.sh /a/b

home_dir=$PWD
total_lines=0
total_files=0
verbose=1

src_lines()
{
	local adir;
	local nlines;
	local nfiles;
	local n;

	adir="$1"
	if [ ! -d "$adir" ]; then 
		echo "$adir: Not found or Not directory"
		return 1
	fi

	cd $adir

	nlines=0;
	src_list=`ls *.[ch] 2> /dev/null`

	nfiles=0
	if [ -n "$src_list" ]; then
		for i in `ls *.[ch]`; do
			n=`wc -l $i | cut -d' ' -f1`;
			nlines=$((nlines+$n))
			nfiles=$((nfiles+1))
		done
		total_lines=$((total_lines+$nlines))
		total_files=$((total_files+$nfiles))
	fi

	if [ "$verbose" == 1 ]; then
		printf "%8s %4s %s\n" "$nlines" "$nfiles" "$adir"
	fi
	return 0
}

target_dir=.
if [ $# -ge 1 ]; then
	target_dir="$1"
fi

cd $target_dir
work_dir=$PWD

for cdir in `find . -type d -print`; do
	src_lines "$cdir" 
	cd $work_dir
done

cd $home_dir

echo
echo "# of files : $total_files" 
echo "# of lines : $total_lines" 
echo

        : srcline.sh /a/b
