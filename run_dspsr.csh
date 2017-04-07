#!/bin/csh

if($#argv < 3) then
    echo "usage: run_dspsr  <dada.key> <file string> <output string> <verbose>"
endif		 

set key = $1
set file_string = $2
set out_string = $3
set verbose = $4

dada_dbmetric -k $key >& /dev/null

if($?==0) then
    if($verbose) dada_header -k $key

    set candidate_file = `dada_header -k $key | grep $file_string | awk '{print $2}'`
    set out = `dada_header -k $key | grep $out_string | awk '{print $2}'`
    
    if($verbose) echo "Waiting for smirf.souped in $out"
    while(! -f $out/smirf.souped )
    end

    cd $out
    set verbose_flag = ""

    echo "DADA INFO:" > ${key}.key
    echo "key $key" >> ${key}.key

    /home/vivek/software/linux_64/bin/dspsr -e car -L 60 -Lmin 60 -A -w $candidate_file 

end 
