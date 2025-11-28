# gradient-grid-random-iteration-coder
in two days i will post some type of photos or images that not depend on simplicity of gradients or plain colors but complexed pixel data and in order to see if a complex photo image of jpg or webp or jxl can become very high in quality dat file compressed and even less size of webp or jxl ,my target now... is quality 80 of jpg or webp or avif or jxl in lossy mode
i need the size of a avif.web.jpg.jxl quality 80 to be bigger than a 20 million iteration grid 6 my dat files and the final quality to be as equal to jxl..
i denote that in images with simple plain color or low gradients it does marks a noise but the noise over complex squares info of yuv just fails on advarege from 0 to 255 , just 5 of a value it means a
y 200 u 150 v 150 can get y 195 u 145 and v 155 for insctances.
​and that on complex data can became like a true photo.. low noise not denotable...

to short explain what the coder do...

it grabs 6 to 6 grid for instances just first yuv pixel ...is s tored , do the adverege the grid of 6 to 6 on a gradient values ... then compares the vaues of gradeint to real values-.
denotes the diference and tryies to random guess the difference on a number of iterations . im ussually using 20 000 000 iterantions but it can get less for more speed or more iterations to 30 000 000 in terms of memory limit for a bit more acurracy..
then the guessed values do not need to be stored just a single 0 or 1 bit for yuv saying its higher than the grandient value or lower..
and just store the random seed for the best guess of yuv.

soo in a grid of 7x7 witch is 147 bytes only stores 4 bytes of random seed iteration the first byte of y and u and v like 7 bytes until now and a single bit of each up or down byte of yuv soo, it means can get to 13 bytes just the grid square of 147 bytes witch is a entrophy compression of 0.8 normally.
