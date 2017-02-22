##For Ubuntu

#    OpenOffice and Unoconv installation Required.

 #   from command prompt

>apt-get remove --purge unoconv
>git clone https://github.com/dagwieers/unoconv
>cd unoconv
>sudo make install

 #   Now add below code in your PHP script and make sure file should be executable.

>shell_exec('/usr/bin/unoconv -f pdf  folder/test.docx');
>shell_exec('/usr/bin/unoconv -f pdf  folder/sachin.png');
