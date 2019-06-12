#
#
#
# list interactive
#awk "-F:" '$3 > 100 && $7 !~ /false/ && $7 !~ /nologin/ && $6 !~ /\/$/ && $1 !~ /ldap/  {print $4 " "$1 "  " $6}' /etc/passwd
for user in `awk "-F:" '$3 > 100 && $7 !~ /false/ && $7 !~ /nologin/ && $6 !~ /\/$/ && $1 !~ /ldap/  {print $1}' /etc/passwd`
do
# Get home dir
home=`grep "^$user:" /etc/passwd |awk -F: '{print $6}'`
#get a shrumken list of groups
	for group in `find $home -ls |awk '{print $6'} |sort|uniq`
	do
	id -nG $user |grep $group >/dev/null 2>&1
	case $? in
	1) echo =========$user
	   find $home -group $group -ls ;;
	esac
	
	done
done

