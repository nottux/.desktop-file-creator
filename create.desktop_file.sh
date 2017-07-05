if [ -f "$HOME/desktop_file_locations.txt" ]
then echo "Here are the locations in $HOME/desktop_file_locations.txt file :"
cat "$HOME/desktop_file_locations.txt"
echo You can enter short names of the locations to select them
eval $(cat "$HOME/desktop_file_locations.txt" | while read -r line; do echo "$line;"; done | sed "s/\\\"/\\\\\"/g" | xargs | rev | cut -c 2- | rev)
else echo "$HOME/desktop_file_locations.txt is not found, you can create the file and enter the short names of locations like that :"
echo "location1=\"/home/someuser/somefolder\""
echo "location_2=\"/home/user/some folder\""
echo "Don't use a,x,i,t,c,n,m,v and b as short name and don't use any special characters"
fi
echo "Enter the .desktop file with directory"
read n
m=$(eval "echo $(echo \$$n)")
if [ -n "$m" -a $n = $(echo $n | tr -d /) ]
then echo "$m path selected, enter the .desktop file name"
read v
n=$(echo "$m/$v")
fi
echo Enter name
read a
a="Name=$a"
echo "Enter Exec line"
read x
x="Exec=$x"
echo "Enter Icon line, if you do not want to specify a icon enter no"
read i
echo "Do you want to start with terminal (yes/no)"
read t
echo "Enter comment, if dont want to enter a comment than enter no"
read c
if [ $i = n -o $i = N -o $i = No -o $i = no -o $i = NO ]
then i="#Icon="
else i="Icon=$i"
fi
if [ $t = n -o $t = N -o $t = No -o $t = no -o $t = NO ]
then t="Terminal=false"
b=u
else b=d
fi
if [ $c = n -o $c = N -o $c = No -o $c = no -o $c = NO ]
then c="#Comment="
else c="Comment=$c"
fi
if [ $t = y -o $t = Y -o $t = Yes -o $t = yes -o $t = YES ]
then t="Terminal=true"
b=u
fi
if [ $b = "d" ]
then echo wrong entry, ending
exit
fi
echo "[Desktop Entry]" > "$n"
echo "$a" >> "$n"
echo "$x" >> "$n"
echo "$i" >> "$n"
echo "$t" >> "$n"
echo "$c" >> "$n"
chmod 777 "$n"
echo "Type=Application" >> "$n"
