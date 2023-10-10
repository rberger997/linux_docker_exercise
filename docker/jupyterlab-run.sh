
Help()
{
   # Display Help
   echo "-------------------------------------------------------------------------------------------------"
   echo ""
   echo "This script will launch a Jupyterlab container from the image rberger997/jupyterlab"
   echo
   echo "Syntax: bash jupyterlab-run.sh -p 7000 -n jupyter1 -r -x newpassword -t 2022-03"
   echo ""
   echo "options:"
   echo "-p or --port        Port to use for browser Jupyterlab (random if none specified)"
   echo "-n or --name        Name of the container"
   echo "-r or --remove      Remove the container when stopped (default is no)"
   echo "-t or --tag         Jupyterlab image tag (2022-03, 2023-08, 2023-08a)"
   echo "-x or --password    Password for Jupyterlab"
   echo "-h or --help        Print this Help"
   echo
   echo "-------------------------------------------------------------------------------------------------"
}


# Set default configuration
port=`shuf -i 7000-8000 -n 1`
remove=false
tag="2023-08a"
password="nimble"


# Flags for assigning port, name, and password
while [ $# -gt 0 ] ; do
  case $1 in
    -p | --port) port="$2" ;;
    -n | --name) name="$2" ;;
    -x | --password) password="$2" ;;
    -r | --remove) remove=true ;;
    -t | --tag) tag="$2" ;;
    -h | --help) Help 
                exit;;

  esac
  shift
done

# Set name
name="jupyter-${port}"

# Check for valid tag name
if [ $tag = '2022-03' ] || [ $tag = '2023-08' ] || [ $tag = '2023-08a' ]
    then
      continue
  else
    echo "Error: Invalid image tag. Choose one of 2022-03 or 2023-08 or 2023-08a"
    exit 1
fi


echo "################################################################"
echo "#"
echo "#               Starting JupyterLab Container"
echo "#"
echo "#   Image:      rberger997/jupyterlab"
echo "#   Tag:        $tag"
echo "#   Port:       $port"
echo "#   Container:  $name"
echo "#   Password:   $password"
echo "#   Remove:     $remove"
echo "# "
echo "################################################################"


#Run the container with specified options
docker run --name $name -d \
	--rm=$remove \
	-p $port:8888 \
	-e JUPYTER_ENABLE_LAB=yes \
	-e JUPYTER_TOKEN=$password \
  -e GRANT_SUDO=yes \
  --user root \
	-v /mnt/data_science:/home/jovyan/data_science \
  -v /usr/share/zoneinfo/America/Detroit:/etc/localtime \
	-t docker.io/rberger997/jupyterlab:$tag


# Show running containers
#echo ""
#echo "Running Containers:"
#echo "docker ps"
#docker ps


# Docker run command for reference
#docker run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -e JUPYTER_TOKEN=nimble -v /mnt/data_science:/home/jovyan/data_science --rm --name jupyter -d rberger997/jupyterlab:2023-08