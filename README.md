# gradient-grid-random-iteration-coder
images that not depend on simplicity of gradients or plain colors but complexed pixel data and in order to see if a complex photo image of jpg or webp or jxl can become very high in quality.
the dat file compressed and even less size of jpg or png like wbp or jxl ,my target now... is quality 80 of jpg or webp or avif or jxl in LOSSLESS mode the dat file
i need the size of a avif.web.jpg.jxl quality 80 to be bigger than a 2 million iteration grid 6 my dat files and the final quality to be as equal to png (LOSSLESS)..
i tryed like a two million iteration random with range of 25 and adv of 16 and tolerance of 12
and produces good image results even on gompress the dat file over lea or paq8px or cmix ...
and the final result remais mostly equal like lossless visual.

to short explain what the coder do...

it grabs 6 to 6 grid for instances just first yuv pixel ...is stored , do the adverege the grid of 6 to 6 on a gradient values ... then compares the values of gradient to real values.
denotes the diference and tryies to random guess the difference on a number of iterations . im usually using 2 000 000 iterations but it can get less for more speed or more iterations to 7 000 000 in terms of memory limit for a bit more acurracy..
then the guessed values do not need to be stored completely just those above tolerance for yuv saying its the good value like lossless.
and just store the random seed of top 4 bytes for the best guess of yuv.

soo in a grid of 7x7 witch is 147 bytes only stores 4 bytes of random seed iteration the first byte of y and u and v like 6 bytes until now and a 2 to 3 single bits or less of each YUV, it means you can get to 10 bytes on a grid and are comprable comressable
just the grid square of 147 bytes witch is a entrophy compression of 0.3 normally.
can become very similar in size of webp and less. can become very good in size like jxl or less.
i would if i was you do check out.


at this moment with normal parameters i can figure out as good as jpg quality or size als as good as avif but the jxl and webp do beat me a good way.
