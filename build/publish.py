import shlex
import subprocess
import os
import sys
from contextlib import contextmanager
import pdb

def execute(command):
    args = shlex.split("docker exec -it {} {}".format(os.getenv('DOCKER_CLIENT_CONTAINER', 'docker-client'), command))
    print("Executing: " + " ".join(args))
    ps = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    print("\n".join(str(ps.communicate()[0]).split("\\r\\n")))

def isMaster():
    return os.getenv('TRAVIS_BRANCH') == 'master'

def isTag():
    travis_tag = os.getenv('TRAVIS_TAG')
    return (travis_tag != None) and bool(travis_tag.strip())

def isPullRequest():
    return os.getenv('TRAVIS_EVENT_TYPE') == 'pull_request'

def publish_tag(repo, tag, newtag):
    publish_tag(repo, tag, repo, newtag)

def publish_tag(repo, tag, newrepo, newtag):
    print("publishing {0}:{1} as {0}:{2}".format(repo, tag, newtag))
    execute("docker tag {0}:{1} {0}:{2}".format(repo, tag, newtag))
    execute("docker push {0}:{1}".format(repo,newtag))

def list_images():
    execute("docker images")

private_repo = sys.argv[1]
tag = sys.argv[2]
public_repo = sys.argv[3]

if (isMaster()):
    publish_tag(private_repo, tag, 'latest')
    publish_tag(private_repo, tag, public_repo, 'latest')
if (isTag()):
    publish_tag(private_repo, tag, os.getenv('TRAVIS_TAG'))
    publish_tag(private_repo, tag, public_repo, os.getenv('TRAVIS_TAG'))
if (isPullRequest()):
    publish_tag(private_repo, tag, os.getenv('TRAVIS_PULL_REQUEST_BRANCH'))

