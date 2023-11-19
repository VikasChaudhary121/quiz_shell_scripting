#!/bin/bash

Sign_up() {
	while true
	do
		echo " "
		read -p "enter your user name" username
        	echo "" 
		if grep -q "^$username" signedin_users
		then
			echo "username alraedy exixsted "
		else
			break
		fi
	done
	read -p "enter your password(should be greater than 8 characters) :" password1
        echo " "
        read -p "Re-enter your password :" password2
	while true;
	do
	if [[ $password1 != $password2 ]]
	then
		read -p " password did not matched please re-enter the password :" password1
		read -p "confirm the password :" password2
		exit 1
	fi
	if [[ ${#password1} -lt 8 ]]
	then 
		read -p "The entered passward lenth is less than 8, please re-rnter the password: " password1
		read -p "confirm your password : " password2
	fi
	break
        done
	echo "$username : $password1" >> signedin_users
	echo "Successfully registered "
}

Sign_in(){
	read -p "Enter your username : " username
	echo
	read -p "Enter your password : " password
	if grep -q "^$username : $password" signedin_users 
	then 
		echo "Successfully loged_in "
		echo
		echo "1) take a quiz "
		echo 
		echo "2) view result "
		echo 
		echo "3) exit"
		echo
		read -p "enter your choice ie: 1,2 or 3 :" choice1
		echo
		if [[ $choice1 == "1" ]]
		then
			take_quiz
		fi
		if [[ $choice1 == "2" ]]
		then
			grep "$username" quiz_result
		else
			echo "exiting "
			exit 1
		fi
	else
		echo "User does not exists "
	fi

}

log_activity(){
	echo "$(date) -$1" >> test_activity.log
}

take_quiz(){
	i=1
	k=1
	j=$((k + 4))
	count=0
	while [ "$i" -lt 4 ]; do
    	sed -n "${k},${j}p" question_bank
    	echo 
    	read -t 10 -p "choose your option : " option
    	ans=$(sed -n "${i}p" answer)
    	if [[ "$option" == "$ans" ]]
    	then 
	    	echo
	    	echo "you choosed right answer !!!! "
	    	echo
	    	c=$((c+1))
    	else 
	    	echo 
	    	echo "you choosed wrong answer !!!"
	    	echo
    	fi
    	k=$((j+1))
    	((i++))
    	j=$((j + 5))
	done
	echo " $(date) :username = $username and password is = $password1 >>>> Number of correct questions : $c , total Number of questons : $((i-1)) " >> quiz_result              
}

while true
do
	echo " ====WELCOME TO THE QUIZ==== "
	echo "Please choose one of the option below "
	echo "1- sign_up"
	echo
	echo "2- sign_in"
	echo
	echo "3- exit"
	echo
	read -p "enter your choice here : " choice
	echo 
	if [[ $choice == "sign_up" ]]
	then
		Sign_up
		break
	fi
	if [[ $choice == "sign_in" ]]
	then
		Sign_in
		break
	fi
	if [[ $choice == "exit" ]]
	then
		echo "exiting"
		exit 0
	else
		echo "invalid choice "
		echo "play again"
	fi

done

