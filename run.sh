DESTDIR="wallpapers"

mkdir -p $DESTDIR

ruby get_all.rb > img_links
cd $DESTDIR

for i in `cat ../img_links`
do
    url=`echo $i | sed s/,.*//`
    name=`echo $i | sed s/.*,//`
    curl -O $url
done
