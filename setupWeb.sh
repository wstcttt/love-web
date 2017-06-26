#for centOS6 64bit
wget http://pypi.python.org/packages/source/s/setuptools/setuptools-2.0.tar.gz
tar zxvf setuptools-2.0.tar.gz
rm -f setuptools-2.0.tar.gz
cd setuptools-2.0
python setup.py build
python setup.py install
cd ..
rm -rf setuptools-2.0
easy_install flask
easy_install gunicorn
rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install nginx
mkdir -p /www
cp -r * /www
