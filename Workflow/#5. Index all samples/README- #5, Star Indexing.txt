In this file are two scripts for star alignment: one for automatic, sequential alignment of many samples, and another for a single sample. 

To account for large genomes, I included scripts to unzip .gz files, index them, and then re-zip afterwards before moving to the next sample. 

This minimizes hard disk usage at the cost of time. Run multiple jobs using the single-indexing method if this constraint does not matter. 