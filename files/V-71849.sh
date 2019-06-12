#!/bin/sh
#
VULN=V71849
STIG=RHEL-07-010010
TITLE="The system package management tool must verify permissions on all files and directories associated with packages."
HN=`hostname`
FINDING=Fail
#
#
OS=`uname`
OSver=`uname -r`
##if [ X${OS} = XSunOS ] || [ X${OSver} != X5.10 ];then exit 1;fi
#
#
>$HN.${VULN}
rpm -Va 2>/dev/null | grep '^.M' >$HN.$VULN

# Loop through each file found
allbad=""
for fl in `cut -c14- $HN.$VULN|sort|uniq`
do
bad=""
#get the package
pkg=`rpm -qf $fl`
perm1=`stat -c %a $fl`
perm2=`rpm -ql $pkg --dump |grep "^$fl " |cut -d" " -f5|cut -c5-`

if [ `echo $perm2 |wc -c` -eq 3 ];
then perm2="0${perm2}"
fi

#User
aa=`echo $perm1 |cut -c1`
bb=`echo $perm2 |cut -c1`
if [ $aa -gt $bb ]
then bad=fail
	allbad=fail
#rpm -q --queryformat "[%{FILENAMES} %{FILEMODES:perms}\n]" $pkg |grep "$fl "
#ls -ld $fl
fi

#Group
aa=`echo $perm1 |cut -c2`
bb=`echo $perm2 |cut -c2`
if [ $aa -gt $bb ]
then bad=fail
	allbad=fail
#rpm -q --queryformat "[%{FILENAMES} %{FILEMODES:perms}\n]" $pkg |grep "$fl "
#ls -ld $fl
fi

#Other
aa=`echo $perm1 |cut -c3`
bb=`echo $perm2 |cut -c3`
if [ $aa -gt $bb ]
then bad=fail
	allbad=fail
#rpm -q --queryformat "[%{FILENAMES} %{FILEMODES:perms}\n]" $pkg |grep "$fl "
#ls -ld $fl
fi
#

#Working on ownership/group
#rpm -ql McAfeeVSEForLinux-2.0.3.29216-29216.x86_64 --dump |grep "^/opt/NAI/package/McAfeeVSEForLinux "|awk '{print $6$7}'
aa=`rpm -ql $pkg --dump |grep "^$fl " |awk '{print $6$7}'`
bb=`ls -ld /opt/NAI/package/McAfeeVSEForLinux|awk '{print $3$4}'`
if [ X$aa != X$bb ]
then bad=fail
	allbad=fail
fi

if [ X$bad == Xfail ]
then rpm -ql $pkg --dump |grep "^$fl " |awk '{print $1, $5, $6, $7}'
     #rpm -q --queryformat "[%{FILENAMES} %{FILEMODES:perms}\n]" $pkg |grep "$fl "
     ls -ld $fl
fi

done
if [ X$allbad == Xfail ]
then echo "$FINDING $VULN $STIG $TITLE" #>>$SC_NAM
else FINDING="Pass"
fi
#echo "$FINDING $VULN $STIG $TITLE" #>>$SC_NAM

rm $HN.${VULN}
