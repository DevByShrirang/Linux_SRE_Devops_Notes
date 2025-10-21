

~ is the home directory of any logged user.

***
ls /sbin - called system binaries 
used for system administartion, debugging boot issue on EC2 or on premise.

ls /lib - used by linux kernel for making system calls to hardware.
 boot   - to boot system. 
ls /bin - called as user binaries.
***

useradd & adduser
useradd is mostly prefer while writting shells script
adduser creates home directory for user

Que:- can we restore linux password? 
if the passowrd is not stored either in file or in LDAP /SSO of orgazatn there is no way to restore password.

/etc/passwd  --store user account details.

/etc/shadow  -- store encrypted user passwords.
/etc/group   -- store group information
/ect/gshadow  -- store secure group details

*****
**Enforcing password policies**
password expiration - chage -M 90 username
**Lock user account**
passwd -l username
**Unlock useraccount**
passwd -u username**

**Modify user**
change the username- usermod -l new_username old_username

**Deleting Users**
  userdel username   -To remove a user but keep their home directory:
  userdel -r username - To remove a user and their home directory:

  