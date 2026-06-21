clear
set -e

# check some things
if ! ping -c 1 -W 2 8.8.8.8 &> /dev/null; then
	echo "You'll need internet connection to use this script."
	exit 1
fi

# look i'm using apis i'm so smart
version=$(curl -s https://api.bfdibranches.com/version.php)
echo "Latest BFDI Branches version is $version"

# path stuff
printf "Enter the path to BFDI Branches: \n"
while true; do
	read -r choice
	choice="${choice//\\ / }"
	case "$choice" in
	"")
		echo "Enter a path:"
		;;
	*)
		if [ -d "$choice/Contents/Resources" ]; then
			cd "$choice/Contents/Resources"
			break
		else
			echo "The app doesn't exist at that location. \n Enter a path:"
		fi
	esac
done

printf "Install custom PCK? (y/n) "
while true; do
	read choice
	case "$choice" in
	y)
		while true; do
			printf "Enter the path of the PCK: \n"
			read -r path
			path="${path//\\/}"
			if [[ $path == *.pck ]]; then
				if [ -f "BFDI Branches.pck" ]; then
					printf "A PCK file already exists, overwrite? (y/n) "
					read -r pckchoice
					case "$pckchoice" in
					y)
						;;
					n)
						echo "Okay."
						exit 0
						;;
					esac
				fi
				cp "$path" "BFDI Branches.pck"
				echo "Custom PCK has been installed."
				exit 0
			else
				echo "That's not a PCK."
			fi
		done
		;;
	n)
		break
		;;
	*)
		printf "(y/n)"
		;;
	esac
done
if [ -f ".bfdibranches_tmp.pck" ]; then
	rm .bfdibranches_tmp.pck
fi
# godot pck files are cross-platform, which is why updating in bfdi branches works at all
curl -o .bfdibranches_tmp.pck https://bfdibranches.com/bfdibranches.pck

# checking if it's already up to date
if [ -f "BFDI Branches.pck" ]; then
	serversum=$(shasum .bfdibranches_tmp.pck | cut -d' ' -f1)
	localsum=$(shasum "BFDI Branches.pck" | cut -d' ' -f1)
	
	if [ "$serversum" = "$localsum" ]; then
		echo "It's already up to date."
		rm .bfdibranches_tmp.pck
	else
		mv .bfdibranches_tmp.pck "BFDI Branches.pck"
		echo "BFDI Branches has been updated."
	fi
else
	mv .bfdibranches_tmp.pck "BFDI Branches.pck"
	echo "The assets for the game have been installed."
fi
