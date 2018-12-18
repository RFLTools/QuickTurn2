if exist quickturn.slb del quickturn.slb
if exist slidelist.txt del slidelist.txt
dir *.sld /b > slidelist.txt
slidelib quickturn.slb < slidelist.txt
del slidelist.txt
