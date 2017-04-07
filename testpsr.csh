#!/bin/csh

foreach pulsar ( `cat pulsars.list` )
    if(! -d ./$pulsar) then
	echo $pulsar
	mkdir $pulsar
	cd $pulsar
	psrcat -all -E $pulsar > ${pulsar}.par
	tempo2 -npsr 1 -f ${pulsar}.par -pred "MOST 57766.2404049769 57767.2404049769 819.970702999999958 820.947265000000016 12 2 3599.9999999999998" >& screen.out
	cd ..
    endif
end
