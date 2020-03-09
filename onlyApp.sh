#!/bin/sh
#$1 : number of times that app test will be deployed
#$2 : number of times that app test will run
#$3 : filename to save results

# initial message
echo -e "\e[0;32mStarting  deployment time test for $1 Application $2 times \e[0m "
echo -e "\e[0;32mResults will be stored in $3 \e[0m "
printf "Generating test files "
#rm onlyApp_script onlyApp_del # remove script files if they were already created
echo "">onlyApp_script # generates a file to store test commands
echo "">onlyApp_del # generates a file to store del commands 
c1="" # string to store container names
c2="" # string to store network names

# gen script to run test 
i=1
while [ $i -le $1 ]
do
b=`expr $i + 8000`
#echo "LOCAL_PORT=800$i COLLECTOR_IP=168.$i.0.$a SUBNET=168.$i.0.0/24  docker-compose --project-name=p$i up -d;">>onlyApp_script
echo "LOCAL_PORT=$b docker-compose --project-name=p$i up -d;">>onlyApp_script
c1="${c1} p${i}_wordpress_1 p${i}_db_1" 
c2="${c2} p${i}_default"
i=`expr $i + 1` # increase i value
done

# gen script to del containers and network 
echo  -e "docker stop ${c1}\ndocker rm -f ${c1}\ndocker network rm ${c2}">>onlyApp_del
printf "...\e[0;32m done \e[0m \n"
echo "%E,%e,%S,%U,%P,%M,%K,%D,%p,%X,%Z,%F,%R,%W,%c,%w,%I,%O,%r,%s,%k,%x">>$3 # print first line to results file

# run test with scripts created storing time and other information to a result file
i=1
while [ $i -le $2 ]
do
echo "--------------------------------------------------------" 
echo -e "\e[0;33mDeployment of $1 app number $i of $2 starts ... \e[0m "
/usr/bin/time -o $3 -a  -f  "%E,%e,%S,%U,%P,%M,%K,%D,%p,%X,%Z,%F,%R,%W,%c,%w,%I,%O,%r,%s,%k,%x" bash onlyApp_script
echo -e "\e[0;32mDeployment finished \e[0m "
printf "Deleting containers/networks" 
bash onlyApp_del >/dev/null # delete containers, network and images created without show them in shell
printf " ...\e[0;32m done \e[0m \n"
i=`expr $i + 1` # increase i value
done
# show message when test is finished 
echo -e "\n--------------------------------------------------------" 
echo -e "\e[0;32mDeployment time test finished \e[0m"
echo "--------------------------------------------------------" 
# show file generated when test is finished
echo "CSV file generated:"
cat "$3"
# remove script files generated
rm onlyApp_del onlyApp_script