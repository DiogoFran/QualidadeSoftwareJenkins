pipeline{
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
execCommand: 'cd /home/mdiogofrancisco/appFolder && npm install',
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
}}
stage('Run automated tests') {
steps {
echo 'Running automated tests'
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
