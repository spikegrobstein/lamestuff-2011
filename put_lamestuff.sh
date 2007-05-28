#! /bin/sh

if [[ "$1" = 'test' ]]; then
	rsync -azv --exclude counter.dat * --delete lamestuff@lamestuff.com:test/
else
	rsync -azv --exclude counter.dat * --delete lamestuff@lamestuff.com:public_html/
fi

