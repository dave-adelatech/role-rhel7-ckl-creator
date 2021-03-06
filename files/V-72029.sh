#
#
#
# list interactive
#awk "-F:" '$3 > 100 && $7 !~ /false/ && $7 !~ /nologin/ && $6 !~ /\/$/ && $1 !~ /ldap/  {print $4 " "$1 "  " $6}' /etc/passwd
for user in `awk "-F:" '$3 > 100 && $7 !~ /false/ && $7 !~ /nologin/ && $6 !~ /\/$/ && $1 !~ /ldap/  {print $1}' /etc/passwd`
do
# Get home dir
home=`grep "^$user:" /etc/passwd |awk -F: '{print $6}'`
# get PGID
group=`grep "^$user:" /etc/passwd |awk -F: '{print $4}'`

#who has wrong ownerships?
find $home -name '\.*' ! -user $user ! -user root ! -group $group -ls
done

