# pyup bot docker image
![Build Status](https://github.com/ckleemann/docker-pyup/workflows/ci/badge.svg)

This docker image provides the latest version of [pyupio](https://pypi.org/project/pyupio/). The pyupip version is automatically updated and pushed to [docker hup](https://hub.docker.com/r/ckleemann/pyup).

## Gitlab CI
To use this image inside a gitlab ci environment as a scheduled task add the following snippet to your ```.gitlab-ci.yml```:

```yaml
pyup:
  image:
    name: ckleemann/pyup
    entrypoint: [""]
  stage: pyup
  only:
    - schedules
  variables:
    GIT_STRATEGY: none
  cache: {}
  before_script:
    - export GITLAB_URL=$(echo $CI_PROJECT_URL | cut -d'/' -f-3)
  script:
    - pyup --provider gitlab --repo=$CI_PROJECT_PATH --user-token=$SCHEDULE_USER_TOKEN@$GITLAB_URL --branch $CI_COMMIT_REF_NAME
```
Then add a scheduled task under CI / CD -> Schedules. In the variables section add ```SCHEDULE_USER_TOKEN``` and the user access token which is used for the API calls.

There are also some not so well documented configuration parameter for gitlab. Add the following snippets to your ```.pyup.yml```:
```yaml
gitlab:
    should_remove_source_branch: True
    merge_when_pipeline_succeeds: False
```
