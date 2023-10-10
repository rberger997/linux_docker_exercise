
Help()
{
   # Display Help
   echo "-------------------------------------------------------------------------------------------------"
   echo ""
   echo "This script will launch an RStudio container from the image rberger997/rstudio-workspace"
   echo
   echo "Syntax: bash rstudio-run.sh -p 7000 -n rstudio1 -r -x newpassword -t 4.0.1a"
   echo ""
   echo "options:"
   echo "-p or --port        Port to use for browser RStudio (random if none specified)"
   echo "-n or --name        Name of the container"
   echo "-r or --remove      Remove the container when stopped (default is no)"
   echo "-t or --tag         RStudio image tag (4.0.1, 4.0.1a, or 4.3.1)"
   echo "-x or --password    Password for RStudio"
   echo "-h or --help        Print this Help"
   echo
   echo "-------------------------------------------------------------------------------------------------"
}


# Set default configuration
port=`shuf -i 7000-8000 -n 1`
remove=false
tag="4.3.1"
password="test"

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
name="rstudio-${port}"


# Set mount point
export username="rstudio"
export mount='/workspaces/codespaces-blank:/home/rstudio/'




echo "################################################################"
echo "#"
echo "#               Starting RStudio Container"
echo "#"
echo "#   Image:      rberger997/rstudio-workspace"
echo "#   Tag:        $tag"
echo "#   Port:       $port"
echo "#   Container:  $name"
echo "#   Username:   $username"
echo "#   Password:   $password"
echo "#   Remove:     $remove"
echo "# "
echo "################################################################"


#Run the container with specified options
docker run --name $name -d \
	--rm=$remove \
	-p $port:8787 \
	-e PASSWORD=$password \
	-v $mount \
  -v /usr/share/zoneinfo/America/Detroit:/etc/localtime \
	-t docker.io/rberger997/rstudio-workspace:$tag



# docker run -d -it -v /mnt/data_science:/home/rstudio/data_science -v /mnt/w-drive:/home/rstudio/w-drive -p 127.0.0.1:8000:8787 -e PASSWORD=nimble --name rstudio_ryan rberger997/rstudio-workspace:4.0.1a

# Show running containers
#echo ""
#echo "Running Containers:"
#echo "docker ps"
#docker ps
