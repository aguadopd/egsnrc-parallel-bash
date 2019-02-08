# egsnrc-parallel-bash
Run EGSnrc codes on multiple cores without a queuing system.

You can run EGSnrc codes "in parallel" on a multi-core system without any queuing system by using the -b -P -j command-line options. Here is a simple bash script that will simplify this on Linux.

Original by [Frederic Tessier](https://github.com/ftessier) , I just added a sleep command that helped me to reduce race conditions on the lock file.

---------

Just saving here because of Google+ shutdown. [Original conversation in the EGSnrc community](https://plus.google.com/+FredericTessierPlus/posts/hRS9Rjztsy3):

**ftessier**: Running EGSnrc codes on multiple cores without a queuing system.

You can run EGSnrc codes "in parallel" on a multi-core system without any queuing system by using the -b -P -j command-line options. Here is a simple bash script that will simplify this on linux.
https://pastebin.com/GvjVejry

**aguadopd**: Thanks a lot for the tool. One problem: Sometimes simulation ends and the *w1.pardose file is not there, and hence the .3ddose file is not generated. Any hints on this? Working on Linux with 2016 release, using 8 cores in a 8 core CPU.

.egsdat, .egslog, .egslst and .errors files of the w1 batch can be found in one of the folders, but without the .pardose file I cannot combine the parallel runs.

Sometimes it works ok! But it's not great to re-run a 13 hours simulation. And this parallel script is not generating any log so I cannot find any more information.

Thanks in advance. Pablo

**ftessier**: Thanks for reporting this Pablo, I hope you can at least recombine the other 7 pardose files! The lock file is often the culprit here. One thing to try is to set NBATCH to 1 instead of 10 in dosxyznrc.mortran, and add a delay in the script between launching individual jobs, in an effort to reduce race conditions on the lock file. Alternatively, consider modifying the script to start independent simulations (wihtout -b -P -j, but ensuring you change the random seeds!), with input files appropriately named so that you end up with w1, w2, ..., w8 pardose files; then trick dosxyznrc into combining those.

If you are able to find a reproducible failure scenario, then please submit an issue on github (https://github.com/nrc-cnrc/EGSnrc/issues).

**aguadopd**: Thanks Frederic. For time reasons I won't be able to try to find a reproducible failure. However, I added a pause command in the for loop, and it didn't fail in at least 4 parallel runs with 7 cores.
So that's my advice.
I leave the script with the pause here, if useful: gist.github.com - parallel.sh

Again, thanks for the script and the fast response. 
