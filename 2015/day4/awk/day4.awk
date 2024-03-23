#! /usr/bin/gawk

BEGIN {
    KEY = "bgvyzdsv";
    LOWEST_NUM = 0;
    while (LOWEST_NUM < 1000000) {
        CMD = "echo -n \""KEY""LOWEST_NUM"\" | md5sum";
        CMD | getline RESULT;
        if (RESULT ~ /^00000/) {
            close(CMD);
            break;
        }
        close(CMD);
        LOWEST_NUM++;
    }
    print("The lowest number that will create an adventcoin with our key is: "LOWEST_NUM);
}
