pipeline {
    agent any
    stages {
        stage('Build/Deploy app to staging-') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                        configName: 'staging',
                        transfers: [
                            sshTransfer(
                            cleanRemote: false,
                            excludes: '',
                            execCommand: 'cd /home/mdiogofrancisco/appFolder && npm install pm2 && pm2 completion install && npm install && sudo pm2 start ./serve.js',
                            execTimeout: 120000,
                            flatten: false,
                            makeEmptyDirs: false,
                            noDefaultExcludes: false,
                            patternSeparator: '[, ]+',
                            remoteDirectory: '',
                            remoteDirectorySDF: false,
                            removePrefix: '',
                            sourceFiles: '**/*')],
                        usePromotionTimestamp: false,
                        useWorkspaceInPromotion: false,
                    verbose: true)])
            } }

        stage('Run automated tests') {
            steps {
                sh 'cd /home/mdiogofrancisco/appFolder'
                sh 'npm prune'
                sh 'npm cache clean --force'
                sh 'npm i'
                sh 'npm install --save-dev mochawesome mochawesome-merge mochawesome-report-generator'
                sh 'rm -f mochawesome.json'
                sh 'npx cypress run --reporter mochawesome'
                sh 'npx mochawesome-merge cypress/results/*.json -o mochawesome-report/mochawesome.json'
                sh 'npx marge mochawesome-report/mochawesome.json'
            }
            post {
                success {
                    publishHTML(
                        target : [
                            allowMissing: false,
                            alwaysLinkToLastBuild: true,
                            keepAll: true,
                            reportDir: 'mochawesome-report',
                            reportFiles: 'mochawesome.html',
                            reportName: 'My Reports',
                            reportTitles: 'The Report'])
                }
            }
        }
        stage('Perform manual testing') {
            steps {
                echo 'Performing manual testing'
            }
        }
        stage('Release to production') {
            steps {
                echo 'Releasing to production'
            }
        }
        }
    }
