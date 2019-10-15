#!groovy

pipeline {  
   agent { 
      dockerfile {
         filename 'Dockerfile'
         args '-u root'
      } 
   }

   stages{
      stage('Build and push MySql Docker Image'){
         steps{
            script{
               withCredentials([usernamePassword(credentialsId: 'ecr-login', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                  sh '''
                  cd Docker
                  docker build -t ec2/mysql .
                  docker tag ec2/mysql:latest 0123456789.dkr.ecr.eu-west-1.amazonaws.com/ec2/mysql:latest
                  docker push 0123456789.dkr.ecr.eu-west-1.amazonaws.com/ec2/mysql:latest
                  cd -
                  '''
               }
            }
         }
      }

      stage('Initialize terraform and apply'){
         steps{
            script{
               withCredentials([usernamePassword(credentialsId: 'ecr-login', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                  sh '''
                  cd terraform
                  terraform init
                  terraform apply -auto-approve
                  cd -
                  '''
               }
            }
         }
      }
   }

}
