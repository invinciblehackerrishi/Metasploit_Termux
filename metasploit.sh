#!/data/data/com.termux/files/usr/bin/bash
echo "##############################################"
echo " TH3 1NV1NC1BL3"
echo "##############################################"

echo "BE PATIENT, ITS WORKING" 

echo "####################################"
apt install -y autoconf bison clang coreutils curl findutils git apr apr-util libffi-dev libgmp-dev libpcap-dev postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config postgresql-contrib wget make ruby-dev libgrpc-dev termux-tools ncurses-utils ncurses unzip zip tar postgresql termux-elf-cleaner
echo "####################################"
apt update && apt upgrade
echo "Downloading & Extracting"

cd $HOME
curl -LO https://github.com/rapid7/metasploit-framework/archive/4.16.16.tar.gz
tar -xf $HOME/4.16.16.tar.gz
mv $HOME/metasploit-framework-4.16.16 $HOME/metasploit-framework
rm $HOME/4.16.16.tar.gz
cd $HOME/metasploit-framework
sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec
gem install bundler
sed 's|nokogiri (1.*)|nokogiri (1.8.0)|g' -i Gemfile.lock

gem install nokogiri -v 1.8.0 -- --use-system-libraries
 
cd $HOME/metasploit-framework
bundle install -j5
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
rm ./modules/auxiliary/gather/http_pdf_authors.rb
if [ -e $PREFIX/bin/msfconsole ];then
        rm $PREFIX/bin/msfconsole
fi
if [ -e $PREFIX/bin/msfvenom ];then
        rm $PREFIX/bin/msfvenom
fi
ln -s $HOME/metasploit-framework/msfconsole /data/data/com.termux/files/usr/bin/
ln -s $HOME/metasploit-framework/msfvenom /data/data/com.termux/files/usr/bin/
termux-elf-cleaner /data/data/com.termux/files/usr/lib/ruby/gems/2.4.0/gems/pg-0.20.0/lib/pg_ext.so
echo "Creating database"

cd $HOME/metasploit-framework/config
curl -LO https://gist.githubusercontent.com/invinciblehackerrishi/2f7e356bfd816d0b5c28bd3ce471db66/raw/4bbea3268dc386b52d45e0130975ee9a5a6b1660/database.yml

mkdir -p $PREFIX/var/lib/postgresql
initdb $PREFIX/var/lib/postgresql

pg_ctl -D $PREFIX/var/lib/postgresql start
createuser msf
createdb msf_database

echo "############################################"
echo "For More Tips & Tricks: Like, Follow & Share”
echo “https://www.facebook.com/TH31NV1NC1BL3/"
echo "############################################"

echo " NOW YOU CAN LAUNCH METASPLOIT BY EXECUTING THE COMMAND :=> ./msfconsole"
