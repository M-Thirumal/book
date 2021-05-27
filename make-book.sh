#Author = Thirumal
#Contact Email = m.thirumal@hotmail.com
#Last modified = 27/05/2021
cp -R img/ docs/img/
fileName=README
output=docs/$fileName
html=docs/index.html
echo "*** Producing HTML ***"
asciidoctor $fileName.adoc -o $html
echo "*** Producing DOCBOOK ***"
asciidoctor -n -b docbook -d book $fileName.adoc -o krltemp.xml 
sed -e s/language=\"groovy\"/language=\"java\"/ krltemp.xml > $fileName.xml
rm krltemp.xml
echo "*** Producing EPUB ***"
pandoc -f docbook -t epub $fileName.xml -o $output.epub
echo "*** Producing MOBI ***"
ebook-convert $output.epub $output.mobi
echo "*** Producing PDF ***"
asciidoctor-pdf $fileName.adoc -o $output.pdf