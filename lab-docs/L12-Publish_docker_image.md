## Build and Publish a Docker image 

1. Write and add dockerfile in the source code
	```sh
		FROM openjdk:8
		ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar demo-workshop.jar
		ENTRYPOINT ["java", "-jar", "demo-workshop.jar"]
	```
   `Check-point:`  version number in pom.xml and dockerfile should match   
2. Create a docker repository in the Jfrog  
    repository name: valaxy-docker
3. Install `docker pipeline` plugin 

4. Update Jenkins file with the below stages  
    ```sh 
	   def imageName = 'sandy01.jfrog.io/sandy-docker/ttrend'
	   def version   = '2.1.2'
        stage(" Docker Build ") {
          steps {
            script {
               echo '<--------------- Docker Build Started --------------->'
               app = docker.build(imageName+":"+version)
               echo '<--------------- Docker Build Ends --------------->'
            }
          }
        }

                stage (" Docker Publish "){
            steps {
                script {
                   echo '<--------------- Docker Publish Started --------------->'  
                    docker.withRegistry(registry, 'artifactory_token'){
                        app.push()
                    }    
                   echo '<--------------- Docker Publish Ended --------------->'  
                }
            }
        }
    ```

Check-point: 
1. Provide jfrog repo URL in the place of `sandy01.jfrog.io/sandy-docker` in `def imageName = 'sandy01.jfrog.io/sandy-docker/ttrend'`  
2. Match version number in `def version   = '2.1.2'` with pom.xml version number  
3. Ensure you have updated credentials(artifactory-cred) in the field of `artifactory_token` in `docker.withRegistry(registry, 'artifactory_token'){`

Note: make sure docker service is running on the slave system, and docker should have permissions to /var/run/docker.sock

Check if container is running using
docker run -dt --name java-app -p 8000:8000 sandy01.jfrog.io/sandy-docker/java-project1:2.1.2

So add 8000 port to inbound security rules of maven slave instance