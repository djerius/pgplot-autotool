#ifndef INC_GETCOLORS_H
#define INC_GETCOLORS_H

int getcolors(
    int vistype,
    Visual **visual,
    Colormap *cmap,
    unsigned long *pix,
    int maxcolors,
    int mincolors,
    unsigned int *depth,
    int maxdepth,
    int mindepth
    );

#endif /* INC_GETCOLORS_H */
