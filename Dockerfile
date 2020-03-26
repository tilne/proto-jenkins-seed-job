FROM jenkins/jenkins:lts

# Install desired plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Create dummy gitconfig
# TODO: figure out why this is needed
COPY gitconfig "$JENKINS_HOME/.gitconfig"
