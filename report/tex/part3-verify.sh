gibson@debian:/tmp$ for entry in /tmp/del3/{,*} ; do ls -lthrd "${entry}"; done | column -t -s' '
drwxr-xr-x  4  gibson  gibson  4.0K  Mar  19  21:28  /tmp/del3/
drwx------  2  root    gibson  4.0K  Mar  19  21:12  /tmp/del3/a1
-rwxr--r--  1  gibson  root    0     Mar  19  21:22  /tmp/del3/a2
drwxr--r--  2  gibson  gibson  4.0K  Mar  19  21:27  /tmp/del3/a3
-rwxrwx---  1  root    root    0     Mar  19  21:28  /tmp/del3/a4
gibson@debian:/tmp$ 
