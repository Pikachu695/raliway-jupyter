FROM ubuntu
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget npm apache2 php php-curl  mysql-server php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring  php-xml php-pear php-bcmath unzip python3 python3-pip screen  -y
RUN  npm install -g wstunnel
RUN mkdir /run/sshd 
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel
RUN a2enmod  rewrite
RUN wget https://raw.githubusercontent.com/jinshulumengchuang/Tuhttpd2/main/000-default.conf
RUN rm /etc/apache2/sites-available/000-default.conf
RUN mv 000-default.conf /etc/apache2/sites-available
RUN echo 'You can play your Railway Cloud NOW! - Message from Uncle LUO!' >/var/www/html/index.html
RUN echo 'wstunnel -s 0.0.0.0:8989 & ' >>/luo.sh
RUN echo 'service mysql restart' >>/luo.sh
RUN echo 'service apache2 restart' >>/luo.sh
RUN echo '/usr/sbin/sshd -D' >>/luo.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo root:uncleluo|chpasswd
RUN chmod 755 /luo.sh
EXPOSE 80
CMD  /luo.sh
###############以上为源文件内容，以下为新添加内容###############
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip  ngrok-stable-linux-amd64.zip
RUN chmod 777 ngrok
RUN ./ngrok authtoken '你的ngrok authtoken'
RUN pip3 install jupyterlab
RUN pip3 install jupyter_http_over_ws
RUN jupyter notebook --generate-config
RUN echo '#c.NotebookApp.allow_root = True' >> ~/.jupyter/jupyter_notebook_config.py
RUN echo 'c.NotebookApp.ip = '0.0.0.0''
RUN wget https://raw.githubusercontent.com/Pikachu695/SomeFile/main/colab.sh
RUN wget https://raw.githubusercontent.com/Pikachu695/SomeFile/main/n.sh