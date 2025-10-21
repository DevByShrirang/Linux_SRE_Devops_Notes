
**pipe** - command1 | command2 | command3

The pipe is used in linux to passing ouput of one command directly to input of another command.

cat ~/day11_test/logs/log1.txt | grep ERROR   --> 
cat ~/day11_test/logs/log1.txt | grep ERROR | wc -l  -->




**Redirections** -
> - Standard output redirection (overwrite)
  helps you to send output or input to files or from file.
   command1  --output--> file. --can be achieved by using redirections.
   command 2   <---input from file --file -- also redirection helps you to send input from file to command.

 ls day11_test > ~/day11_test/files.txt
    > is a redirection operator.
    It redirects the output of command into file.
ls day11_test --> lists the content of directory.day11_test
>                 --> redirects that output
~/day11_test/files.txt  --> is the destination file where the output will be stored.

>> - standard output redirection (append)

< - standard input redirection.

grep ERROR < ~/day11_test/logs/log1.txt

this command uses input redirection. the < operator tells the shell to take inputfrom specified file instead of from keyborad. here the contents of log1.txt are passed as input to grep, which seraches for the pattern "ERROR" inside the file>




**wildcards** -
    Help us to match files with pattern.
       suppose i want to list files from current directories which ends with txt. i want to list only text file from directory . we can use *pattern

ls *.txt


**Links** 
     lINKS are nothing but pointers to files/directories.
  soft links
  Hard links


