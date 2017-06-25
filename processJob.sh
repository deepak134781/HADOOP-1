dialog --menu "Select Your Choice" 70 50 11 1 "Run a job" 2 "List active job" 3 "List all job"  4 "View Job Status" \
 5 "Kill a job" 6 "change priority of a job " 7 "Exit" 2>/tmp/process.txt

ch=` cat /tmp/process.txt `

	case $ch in
	1)
		dialog --inputbox "Please Enter Path of File for operatin" 8 40 2> /tmp/tmp1.txt
		file=`cat /tmp/tmp1.txt`
		dialog --inputbox "Please Name of output directory" 8 40 2> /tmp/tmp2.txt
		fileout=`cat /tmp/tmp2.txt`
		hadoop jar /usr/share/hadoop/hadoop-examples-1.2.1.jar  wordcount $file $fileout
		out=` hadoop fs -cat $fileout/part* `
		echo $out > /tmp/tmp1.txt
		dialog --textbox /tmp/tmp1.txt 20 40
	;;
	2)
		hadoop job -list > /tmp/tmp1.txt
		dialog --textbox /tmp/tmp1.txt 100 200
	;;
	3)
		out=` hadoop job -list all `
		echo $out > /tmp/tmp1.txt
		dialog --textbox /tmp/tmp1.txt 100 200
	;;
	4)
		dialog --inputbox "Enter job id" 8 40 2> /tmp/tmp1.txt
		id=` cat /tmp/tmp1.txt `
		hadoop job -status $id  > /tmp/tmp1.txt
		dialog --textbox /tmp/tmp1.txt 0 100
	
	;;
	5)
		dialog --inputbox "Enter job id" 8 40 2> /tmp/tmp1.txt
		id=` cat /tmp/tmp1.txt `
		out=` hadoop job -kill $id `
		echo $out > /tmp/tmp1.txt
		dialog --textbox /tmp/tmp1.txt 0 100
	;;
	6)
		dialog --inputbox "Enter job id" 8 40 2> /tmp/tmp1.txt
		id=` cat /tmp/tmp1.txt `
		dialog --radiolist "Select Your Choice" 70 50 11 \
		"VERY_HIGH"  ".........." off \
		"HIGH" "........" off \
		"NORMAL" "......" on \
 		"LOW" "...." off \
 		"VERY_LOW" ".." off 2>/tmp/tmp1.txt
		pr=` cat /tmp/tmp1.txt `
		out=` hadoop job -set-priority $id $pr `
		echo $out > /tmp/tmp1.txt
		dialog --textbox /tmp/tmp1.txt 20 40
	;;
	7) 
		bash clientInterface.sh
	esac
	
bash processJob.sh
    
