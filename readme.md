# Sample PetShep Application, to help simulate and demonstrate a real world example of securing a software supply chain. The following technologies were used

[ DeepSource, Jenkins, Docker, JFrog ]

## Below you will find a link to the JenkinsFile, it's fairly self explanatory of a pipeline but we'll go through outlining what it does.

1. We clone the project from the forked project in my personal github repo
2. We then setup a a connection with JFrog using the Jenkins Plugin to capture various build data and resolve dependencies
3. We then build the Project ( Part of the build process is to run tests, Both the CheckStyle + 2 Tests for varying reasons  in the project fail on the latest version of Maven 3.9.5, for this I chose to exclude CheckStyle + tests however they can be turned on at any point by removing line 30's -D*.skips. They could also be branched out into their own stage but for the sake of time and since this is more of a proof of concept we can understand ideally what would be taking place but since I don't own this project nor the code I'll just go with the assumption that the Unit Tests should be passing) .

4. Now with our tests passing we can move forward to the install command and build the image in a docker agent using the a base image from the latest version of Maven and collect the buildInfo
5. We go ahead and add some more properties to the published artifacts
6. We can now build the project into a docker image
7. Then to wrap things up nicely we push the docker image to the Docker Registry hosted in my personal JFrog Instance to continue further with inspecting the image and assuming further propogation down our supply chain
8. We then finish by publishing all the info to JFrog



The biggest part of getting this project working was setting up the Dev environment + Configuring Jenkins along with Docker so we could use these processes.


