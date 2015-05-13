#ifndef INC_GETDATA_H
#define INC_GETDATA_H

int getdata(
    XSelectionEvent event,
    unsigned short *rbuf,
    int *rbuflen,
    Window srcwin,
    int *selset
    );

#endif /* INC_GETDATA_H */
