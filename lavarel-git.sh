# 初始化脚本
init=false
SRC_DIR=/var/opt/www/qa/vr

function pull {

	git fetch && git checkout ${branch};
	git pull;
}

#making repos directory
if [ ! -d "$SRC_DIR" ]; then 
	mkdir $SRC_DIR; 
	cd /var/opt/www/qa
	git clone http://jenkins:1xcxi_9kZny252ww35kx@git.bayanvr.com:81/Fafu/vr.git vr 
	cd vr
else 
	cd /var/opt/www/qa/vr
	if [ ! -d .ssh ]; then
		# 初始化 git
		git init
		git remote add origin http://jenkins:1xcxi_9kZny252ww35kx@git.bayanvr.com:81/Fafu/vr.git
	fi

	# 更新代码
	pull;
fi

# 拷贝文件
cp .env.example .env

# 更新 composer
docker run --rm -v /var/opt/www/qa/vr:/data imega/composer install 
