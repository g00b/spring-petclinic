node {
    def server = Artifactory.server 'ART'
    def rtMaven = Artifactory.newMavenBuild()
    def rtDocker
    def buildInfo

    stage ('Clone') {
        git branch: 'main', url: 'https://github.com/g00b/spring-petclinic.git'
    }

    //
    stage ('Artifactory configuration') {
        def jfrogInstance = JFrog.instance 'ART'
        rtServer = jfrogInstance.artifactory
        rtDocker = Artifactory.docker server: rtServer

        // Tool name from Jenkins configuration
        rtMaven.tool = 'maven'
        rtMaven.deployer releaseRepo: 'test-release-local', snapshotRepo: 'test-libs-snapshot-local', server: rtServer
        rtMaven.resolver releaseRepo: 'test-libs-release', snapshotRepo: 'test-libs-snapshot', server: rtServer

        buildInfo = Artifactory.newBuildInfo()
        buildInfo.env.capture = true
    }


    stage ('Build Maven Project in Container') {
        docker.image('maven:3.9-eclipse-temurin-17').inside {
            //withEnv(['JAVA_HOME=/usr/local/openjdk-8']) { // Java home of the container
                rtMaven.run pom: 'pom.xml', goals: 'clean -Dcheckstyle.skip -Dmaven.test.skip=true install', buildInfo: buildInfo
            //}
        }
    }
        
    stage ('Add properties') {
        // Attach custom properties to the published artifacts:
        rtDocker.addProperty("pet-clinic", "docker1").addProperty("status", "stable")
    }
    

    stage ('Build docker image') {
        docker.build('gabetest.jfrog.io/docker-local/pet-clinic:latest', '.')
    }

    stage ('Push image to Artifactory') {
        rtDocker.push 'gabetest.jfrog.io/docker-local/pet-clinic:latest',  'docker-local', buildInfo
    }

    stage ('Publish build info') {
        rtServer.publishBuildInfo buildInfo
    }
}

