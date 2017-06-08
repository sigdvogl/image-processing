#!/usr/bin/env bash
cat list.txt | while read i; do
##cp 250x250/$i /Volumes/Bilddaten/Spw/$i
#
## Move old Images in .sic folders
##mv /Volumes/Bilddaten/master/Spw_250x250/$i /Volumes/Bilddaten/master/Spw_250x250.sic/$i
##mv /Volumes/Bilddaten/master/Spw_250x250_branding/$i /Volumes/Bilddaten/master/Spw_250x250_branding.sic/$i
##mv /Volumes/Bilddaten/master/Spw_300dpi/$i /Volumes/Bilddaten/master/Spw_300dpi.sic/$i
##mv /Volumes/Bilddaten/master/Spw_450x450/$i /Volumes/Bilddaten/master/Spw_450x450.sic/$i
## cp /Volumes/Bilddaten/master/Spw_800x600/$i $DATE/Spw_800x600.sic/$i
##mv /Volumes/Bilddaten/master/Spw_800x600_branding/$i /Volumes/Bilddaten/master/Spw_800x600_branding.sic/$i
#mv /Volumes/Bilddaten/master/Spw_2000x2000/$i $DATE/Spw_2000x2000.sic/$i
#
## Move new Images in Master folders
cp 250x250/$i /Volumes/Bilddaten/Spw/$i
mv 250x250/$i /Volumes/Bilddaten/master/Spw_250x250/$i
##mv 250x250_Branding/$i /Volumes/Bilddaten/master/Spw_250x250_branding/$i
mv 300dpi/$i /Volumes/Bilddaten/master/Spw_300dpi/$i
##mv 450x250/$i /Volumes/Bilddaten/master/Spw_450x450/$i
##mv 800x600/$i /Volumes/Bilddaten/master/Spw_800x600/$i
##mv 800x600_Branding/$i /Volumes/Bilddaten/master/Spw_800x600_branding/$i
mv 2000x2000/$i /Volumes/Bilddaten/master/Spw_2000x2000/$i
done
