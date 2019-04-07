#! etc/bin/bash
function Menu(){
 echo -e "1. Change owner\n2. Change perition\n3. Show info\n0. Exit"
 read choice
}

function ChangeOwner (){
 clear
   echo "Enter new owner username: "
   read newUserName
   cat /etc/passwd | grep $newUserName
        if (( $? == 0 ))
           then
           echo "User exist!"
           else
	   echo "User does not exist"
	fi
	echo "Enter group owner"
	read newGroup
	cat /etc/group | grep $newGroup
	if (($? == 0))
	then 
	echo "Group exist!"
	else
	echo "Group does not exist"
	fi
	echo "Enter a full path of file or directory to change owner"
	read path
	chown $newUserName:$newGroup $path
	echo "Owner has successfuly changed"
}


function ChangePermition (){
	clear
	echo -e "Enter a path to file or directory to change permitions"
	read Path
	cat $Path
	if (($? == 0))
	echo "file exist"
	then
	clear
	echo -e  "1. For group change permision\n2. For user change permition\n3. For other users perition"
	read userchoise
	case $userchoise in
	1)
	clear 
	echo "Enter a new permitions with (+) (-) rwx"
	read userperm
	chmod u"$userperm" $Path
	;;
	2) 
	clear
	echo "Enter a new permitions for group (+) (-) rwx"
	read groupperm
	chmod g"$userperm" $Path
	;; 
	3) 
	clear
	echo "Enter new permitions for other (+) (-) rwx"
	read otherperm
	chmod o"$otherperm" $Path
	;; 
	*)
	echo "Error"
	esac
	else 
	echo "File does not exist"
	fi


}

function ShowInfo(){
	echo 
	echo "Enter path to file to display"
	read Pathdispl
 	cd $Pathdispl | ls -l
	if (($? == 0))
	then
	echo "Path exist"
	else 
	echo "Path does not exist"
	fi
}

exit=true

while [ $exit == true ]
do
 Menu;
 case $choice in
   1) ChangeOwner; ;;
   2) ChangePermition; ;;
   3) ShowInfo; ;;
   0) echo "Bye!"; let exit=false ;;
   *) echo "R.T.F.M."; ;;
 esac
done
