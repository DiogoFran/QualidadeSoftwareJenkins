pipeline {
    agent any

    tools { nodejs 'NodeJS' }

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
                            execCommand: 'cd /home/mdiogofrancisco/appFolder && apt-get install libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb && npm install cypress --save-dev && npm install @badeball/cypress-cucumber-preprocessor && npm install @bahmutov/cypress-esbuild-preprocessor && npm install pm2 && pm2 completion install && npm install && sudo pm2 start ./serve.js -f',
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
                echo 'Running automated tests'
                sh 'npm prune'
                sh 'npm cache clean --force'
                sh 'npm i'
                sh 'npm install --save-dev mochawesome mochawesome-merge mochawesome-report-generator'
                sh 'npx cypress run --config baseUrl="http://34.18.17.202" --browser ${BROWSER} --spec ${SPEC} --reporter mochawesome'
                
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
