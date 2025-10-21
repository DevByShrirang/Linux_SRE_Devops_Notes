
useradd - add user in non-interactive
adduser - add user in interactive -(prompts for detail)
passwd - set or change user passowrd
usermod - modifies an 
 user attributes
groupadd - create a new group
Chown - used to change file permission
chmod -- changing file permission
set facl ->
getfacl

**User types**
system users:-
    system users having UID less than 1000.

Regular user:-
    regular users having UID >= 1000

/etc/passwd -> stores user account information.
username
passwd
UID
GID
GECOS
home
shell

/etc/shadow - secure storage for password(encrypted password) of users.

/etc/sudoers - It controls who can use sudo & what they can run.
/etc/group - shows the user group information

------------
--------adduser shrirang                  -- Addition of user
        groupadd devops   -               -- creation of group
        sudo gpasswd -a shrirang devops   -- Add user into group
        sudo gpasswd -d shrirang devops   -- remove user from group


file ownership and permission
 