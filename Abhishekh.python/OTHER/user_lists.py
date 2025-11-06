User_list = ['shrirang', 'shree', 'devops', 'engineer']

print(User_list)

print(User_list[0])
print(User_list[3])

User_list.append('master')  # to add new item in list
print(User_list)

User_list.remove('engineer')  # To delete values from list.
print(User_list)

User_list[2] = 'Devops'  # To modify value from list.
print(User_list)

User_list.insert(1, 'Patil') # To add value in list
print(User_list)

del User_list[4]  # To delete values from list.
print(User_list)

#No of items in List.
print(len(User_list))

# Sorting lf list
User_list.sort(reverse=True)
print(User_list)

