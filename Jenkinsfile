pipeline {
    environment {
        DOCKERHUB_CREDENTIALS = credentials("dhubcredd")
    }
    agent {
        label "K-M"
    }
    stages {
        stage('Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Juhika14/PRT-WEBSITE.git'
            }
        }
        stage('Docker') {
            steps {
                sh 'sudo docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}'
                sh 'sudo docker build -t juhika/prt_test /home/ubuntu/jenkins/workspace/Test-PRT-Website/'
                sh 'sudo docker push juhika/prt_test'
            }
        }
        stage('K8s') {
            steps {
                sh 'kubectl apply -f deploy.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }
    }
}
