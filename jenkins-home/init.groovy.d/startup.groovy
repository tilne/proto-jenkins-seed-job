import jenkins.model.Jenkins
import hudson.model.*
import java.util.logging.Logger

Logger.global.info("[Running] startup script")

Jenkins.instance.save()

buildJob('seed')

Logger.global.info("[Done] startup script")

private def buildJob(String jobName) {
    Logger.global.info("Building job $jobName")
    def job = Jenkins.get().getJob(jobName)
    Jenkins.get().getQueue().schedule(job, 0, new CauseAction(new Cause() {
        @Override
        String getShortDescription() {
            'Jenkins startup script'
        }
    }))
}
