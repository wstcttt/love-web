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

cat > /etc/nginx/conf.d/default.conf << 'END'
server {
    listen       80;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/log/host.access.log  main;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_redirect off;
        proxy_set_header Host $host:80;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}
END
cd /www
service nginx start
nginx -s reload
gunicorn -w 4 -b 0.0.0.0:5000 run:app
echo "Done"
