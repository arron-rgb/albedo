BUILD_ID=DONTKILLME

# 加载配置参数
. /etc/profile

# 配置运行参数
export PROJ_PATH=`pwd`
export JAR_PATH=/data/overtime

# base函数
kill()
{
    pid=`ps -ef|grep albedo|grep java|awk '{print $2}'`
    echo "albedo Id list :$pid"
    if [ "$pid" = "" ]
    then
      echo "no albedo pid alive"
    else
      kill -9 $pid
    fi
}

cd $PROJ_PATH/albedo-ui/
npm build:prod

cd $PROJ_PATH/albedo-modules/albedo-admin/target/
mvn clean package
# 杀死原有的overtime进程
kill
# 删除原有工程
rm -f $JAR_PATH/albedo-admin.jar
# 复制新的工程到指定目录
cp $PROJ_PATH/albedo-modules/albedo-admin/target/albedo-admin.jar $JAR_PATH/
# 切换到指定目录
cd $JAR_PATH/

# springboot项目
nohup java -jar albedo-admin.jar > nohup.out &
