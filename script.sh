#! /bin/bash
function Menu(){
 echo -e "1. Create user\n2. Delete user\n3. Create group\n4. Delete group\n5. Edit user\n6. Show info\n0. Exit"
 read choice
}

function CreateUser (){
 clear
 echo -e "1) Name\n2) Name + UID + GID"
 read userChoice

 if (( $userChoice == 1 ))
 then
   echo "Enter username: "
   read newUserName
   cat /etc/passwd | grep $newUserName
        if (( $? == 0 ))
           then
           echo "User exist!"
           else
           useradd $newUserName
           passwd $newUserName
	fi
    elif (( $userChoice == 2 ))
    then
    echo "User choice 2"
    echo "Enter username"
    read newUserName
    cat /etc/passwd | grep $newUserName
           if (( $? == 0))
	   then
           echo "User exist!"
       else
    echo "Enter UID"
    read userUid
    echo "Enter GID"
    read userGid
    useradd -u $userUid -g $userGid $newUserName
    passwd $newUserName
    fi
    else 
    echo "Wrong choise"
    fi
}

function UserDelete (){
clear
echo "Enter user to delete"
read userDelete
cat /etc/passwd | grep $userDelete
if (($? == 1))
then 
echo "User does not exist"
else
        echo -e "Are you sure to remove \t$userDelete\n Enter Y to remove or N to cancel"
	read choise
	if [[ $choise  == "Y" || $choise == "y" ]]
	then
	userdel -r  $userDelete  
	echo "Succesfuly delete $userDelete"
	elif [[ $choise == "N" || $choise == "n" ]]
	then	
	echo "Canceled"
	else
	echo "Wrong  choise"
	fi
fi
}

function CreateGroup (){
	clear
	echo "Adding a group"
	echo "Enter name of group"
	read groupImput
	cat /etc/group | grep $groupImput
	if (($? == 1))
	then
	echo "Enter group GID"
	read groupid
	groupadd $groupImput -g $groupid
	echo "Group created $(cat /etc/group | grep $groupImput)"
	else 
	echo "Group exist"
	fi
}

function DeleteGroup (){
	clear
	echo "Deleating a group"
	echo "Enter name of group"
	read groupImput
	cat /etc/group | grep $groupImput
	if (($? == 0))
	then
	groupdel $groupImput
	echo "Group successfully delete"
	else
	echo "Group does not exist"
	fi

}

function EditUser (){
	clear
	echo "Enter Username to adjust"
	read userName
	cat /etc/passwd | grep $userName
	if (($? == 0))	
	then
	echo -e  "User exist\nUser menu\n1.Update pass\n2.Update ID\n3.Update group\n4.Change home directory"
	read userchoise
	case $userchoise in
	1)
	clear 
	echo "Enter a new password"
	passwd $userName
	;;
	2) 
	clear
	echo "Enter new ID"
	read newid
	usermod -u $newid $userName
	;; 
	3) 
	clear
	echo "Enter new group for user"
	read newgroup
	usermod -g $newgroup $userName
	echo -e "$(cat /etc/passwd | grep $userName)"
	;; 
	4)
	clear
	echo "Enter a new home directory"
	read homedirectory
	usermod -d /home/$homedirectory $userName
	echo "Directory changed"
	;; 
	*)
	echo "Error"
	esac
	else
	echo "User does not exist"
	fi
}

function ShowInfo(){
	echo 
	echo "Enter user to display"
	read userName
	cat /etc/passwd | grep $userName
	if (($? == 0))
	then
	echo "$(id $userName)"
	else 
	echo "User does not exist"
	fi
}

function New (){
}

exit=true

while [ $exit == true ]
do
 Menu;
 case $choice in
   1) CreateUser; ;;
   2) UserDelete; ;;
   3) CreateGroup; ;;
   4) DeleteGroup; ;;
   5) EditUser; ;;
   6) ShowInfo; ;;
   0) echo "Bye!"; let exit=false ;;
   *) echo "R.T.F.M."; ;;
 esac
done
