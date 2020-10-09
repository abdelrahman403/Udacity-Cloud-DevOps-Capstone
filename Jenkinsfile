pipeline {
	agent any
    environment {
        DOCKER_IMAGE_NAME = "abdelrahman16/capstone"
	}
	stages {

		stage('Lint HTML') {
			steps {
				sh 'tidy -q -e *.html'
			}
		}
		
		stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                    app.inside {
                        sh 'echo Hello, Nginx!'
                    }
                }
            }
		}

		stage('Push Image To Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
		}

//		stage('Deploy blue container') {
//            steps {
//                kubernetesDeploy(
//                    kubeconfigId: 'kubeconfig',
//                    configs: 'k8s/blue-dep.yaml',
//                    enableConfigSubstitution: true
//                )
//            }
//        }

        stage('blue Deployment'){
            steps {
                withAWS(region:'us-east-2', credentials:'aws-cred'){
                    sh "kubectl apply -f k8s/Green/blue-dep.yaml"
                }
            }
        }

        stage('Deploy green container') {
            steps {
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'k8s/green-dep.yaml',
                    enableConfigSubstitution: true
                )
            }
        }

        stage('Create the service in the cluster, redirect to blue') {
            steps {
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'k8s/blue-svc.yaml',
                    enableConfigSubstitution: true
                )
            }
		}

        stage('Wait user approve') {
            steps {
                input "Ready to redirect traffic to green?"
            }
        }

        stage('Create the service in the cluster, redirect to green') {
            steps {
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'k8s/green-svc.yaml',
                    enableConfigSubstitution: true
                )
            }
        }

	}
}