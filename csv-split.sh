#!/bin/bash
FILENAME=$1
SIZE=$2
PREFIX=${FILENAME%%.*}".part"
SUFFIX=${FILENAME#*.}
HDR=$(head -1 $FILENAME)   # Pick up CSV header line to apply to each file
split -l $SIZE --additional-suffix=$SUFFIX $FILENAME $PREFIX   # Split the file into chunks of 20 lines each
n=1
for f in $PREFIX*              # Go through all newly created chunks
do
   echo $HDR > Part${n}    # Write out header to new file called "Part(n)"
   cat $f >> Part${n}      # Add in the 20 lines from the "split" command
   rm $f
   mv Part${n} $PREFIX$n"."$SUFFIX                   # Remove temporary file
   ((n++))                 # Increment name of output part
done
