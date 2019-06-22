
cd benchmark
temp=datazip$$
mkdir -p /tmp/$temp/data
cp data/blogs.txt /tmp/$temp/data
cp data/tweets.txt /tmp/$temp/data
cd /tmp/$temp
zip -r data data
echo File is /tmp/$temp/data.zip
