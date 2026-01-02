pipeline {
    agent any   // 🔥 Single global agent (no stage-level agents)

    tools {
        jdk 'JDK17'
        maven 'Maven'
    }

    environment {
        SONARQUBE_SERVER = 'http://34.229.39.175:9000'
        SONARQUBE_TOKEN  = 'squ_aa5e62c5e4b239d040227e37930671ede97fb85b'
        MVN_SETTINGS     = '/etc/maven/settings.xml'

        NEXUS_URL        = 'http://44.202.69.41:8081'
        NEXUS_REPO       = 'maven-releases'
        NEXUS_GROUP      = 'com.web.cal'
        NEXUS_ARTIFACT   = 'webapp-add'

        TOMCAT_URL       = 'http://34.227.226.60:8080/manager/text'
    }

    stages {

        /* === Stage 1: Checkout Code === */
        stage('Checkout Code') {
            steps {
                echo '📦 Cloning source from GitHub...'
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/uday79936/Medical-Store-Dashboard.git'
                    ]]
                ])
            }
        }

        /* === Stage 2: SonarQube Analysis === */
        stage('SonarQube Analysis') {
            steps {
                echo '🔍 Running SonarQube static analysis...'
                sh '''
                mvn clean verify sonar:sonar \
                  -DskipTests \
                  -Dsonar.host.url=${SONARQUBE_SERVER} \
                  -Dsonar.login=${SONARQUBE_TOKEN} \
                  --settings ${MVN_SETTINGS}
                '''
            }
        }

        /* === Stage 3: Build Artifact === */
        stage('Build Artifact') {
            steps {
                echo '⚙️ Building WAR...'
                sh '''
                mvn clean package -DskipTests --settings ${MVN_SETTINGS}
                echo "✅ Build Completed!"
                ls -lh target/*.war
                '''
            }
        }

        /* === Stage 4: Upload Artifact to Nexus === */
        stage('Upload Artifact to Nexus') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'nexus',
                        usernameVariable: 'NEXUS_USR',
                        passwordVariable: 'NEXUS_PSW'
                    )
                ]) {
                    sh '''
                    set -e
                    WAR_FILE=$(find target -name "*.war" | head -n1)
                    VERSION="0.0.${BUILD_NUMBER}"
                    GROUP_PATH=$(echo "${NEXUS_GROUP}" | tr '.' '/')

                    echo "📤 Uploading WAR to Nexus..."
                    curl -f -u "${NEXUS_USR}:${NEXUS_PSW}" --upload-file "$WAR_FILE" \
                    "${NEXUS_URL}/repository/${NEXUS_REPO}/${GROUP_PATH}/${NEXUS_ARTIFACT}/${VERSION}/${NEXUS_ARTIFACT}-${VERSION}.war"

                    echo "✅ Artifact uploaded successfully!"
                    '''
                }
            }
        }

        /* === Stage 5: Deploy to Tomcat === */
        stage('Deploy to Tomcat') {
            steps {
                withCredentials([
                    usernamePassword(credentialsId: 'nexus',  usernameVariable: 'NEXUS_USR',  passwordVariable: 'NEXUS_PSW'),
                    usernamePassword(credentialsId: 'tomcat', usernameVariable: 'TOMCAT_USR', passwordVariable: 'TOMCAT_PSW')
                ]) {
                    sh '''
                    set -e
                    cd /tmp
                    rm -f *.war

                    VERSION="0.0.${BUILD_NUMBER}"
                    GROUP_PATH=$(echo "${NEXUS_GROUP}" | tr '.' '/')
                    WAR_URL="${NEXUS_URL}/repository/${NEXUS_REPO}/${GROUP_PATH}/${NEXUS_ARTIFACT}/${VERSION}/${NEXUS_ARTIFACT}-${VERSION}.war"

                    echo "⬇️ Downloading WAR from Nexus..."
                    curl -u "${NEXUS_USR}:${NEXUS_PSW}" -O "$WAR_URL"

                    APP_NAME="${NEXUS_ARTIFACT}"

                    echo "🧹 Undeploying old application..."
                    curl -u "${TOMCAT_USR}:${TOMCAT_PSW}" \
                      "${TOMCAT_URL}/undeploy?path=/${APP_NAME}" || true

                    echo "🚀 Deploying new WAR to Tomcat..."
                    curl -u "${TOMCAT_USR}:${TOMCAT_PSW}" --upload-file "${APP_NAME}-${VERSION}.war" \
                      "${TOMCAT_URL}/deploy?path=/${APP_NAME}&update=true"

                    echo "✅ Deployment successful!"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '🎉 Pipeline completed successfully — Application live on Tomcat!'
        }
        failure {
            echo '❌ Pipeline failed — Check Jenkins logs.'
        }
    }
}
