pipeline {
    agent any

    tools { nodejs 'NodeJS' }

    options{
        ansiColor('xterm')
    }

    parameters {
        string(name: 'SPEC', defaultValue:'cypress/e2e/1-getting-started/todo.cy.js', description: 'Enter the cypress script path that you want to execute')
        choice(name: 'BROWSER', choices:['electron', 'chrome', 'edge', 'firefox'], description: 'Select the browser to be used in your cypress tests')
    }

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
                            excludes: 'node_modules/,cypress/,**/*.yml',
                            execCommand: 'cd /vr/www/html && npm install && pm2 restart npm serve.js || pm2 start npm serve.js',
                            execTimeout: 120000,
                            flatten: false,
                            makeEmptyDirs: false,
                            noDefaultExcludes: false,
                            patternSeparator: '[, ]+',
                            remoteDirectory: "",
                            remoteDirectorySDF: false,
                            removePrefix: "",
                            sourceFiles: "**/*")],
                        usePromotionTimestamp: false,
                        useWorkspaceInPromotion: false,
                    verbose: true)])
            } }

        stage('Run automated tests') {
            steps {
                echo 'Running automated tests'
                sh 'npm prune'
                sh 'npm cache clean --force'
                sh 'npm i'
                sh 'npm install -g cypress --force'  //forçar instalação do cypress
                sh 'npm install --save-dev mochawesome mochawesome-merge mochawesome-report-generator'
                sh 'npm run e2e_tests'
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
                timeout(activity: true, time: 5) {
                    input 'Proceed to production?'
                }
           }
        }
        stage('Release to production') {
            steps {
                echo 'Releasing to production'
            }
        }

        }
    }
