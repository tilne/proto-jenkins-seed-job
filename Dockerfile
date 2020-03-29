FROM jenkins/jenkins:lts

# Install desired plugins
COPY --chown=jenkins:jenkins jenkins-home/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Copy hook scripts into place
COPY --chown=jenkins:jenkins jenkins-home/init.groovy.d $JENKINS_HOME/init.groovy.d/

# Copy seed job config into place
COPY --chown=jenkins:jenkins jenkins-home/jobs $JENKINS_HOME/jobs/

# Create dummy gitconfig. This is only needed because the job is using the dummy github repo.
COPY --chown=jenkins:jenkins jenkins-home/gitconfig $JENKINS_HOME/.gitconfig

# Needed to enable downstream builds queued by seed to clone repo
# More info at https://jenkins.io/blog/2018/03/15/jep-200-lts/
ENV JAVA_OPTS -Djenkins.security.ClassFilterImpl.SUPPRESS_WHITELIST=true
