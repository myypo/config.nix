function downdock
    docker stop $(docker ps -aq)
    docker rm $(docker ps -a -q)
end
