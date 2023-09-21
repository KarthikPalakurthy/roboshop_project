#Assigning a name to a set of data is called variables

num=5 # Default way of assigning a variable, no spaces

echo $num

# Command substitution:

DATE=$(date +%F)
echo Hey, the date is ${DATE}

#Arithmetic subsititution:

var=$((2*3))

echo $var