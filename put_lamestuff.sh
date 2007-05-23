#! /bin/sh

rsync -azv --exclude counter.dat * --delete lamestuff@lamestuff.com:public_html/
