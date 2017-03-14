#!/bin/sh

echo 'Start crawling'

nutch inject /urls

for i in $(seq ${ITERATIONS}); do
    echo "Iteration $i"
    nutch generate -topN 5000
    nutch fetch -all
    nutch parse -all
    nutch updatedb -all
done

echo 'Done with all iterations'
