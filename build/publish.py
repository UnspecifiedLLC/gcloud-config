import subprocess
import shlex
from contextlib import contextmanager
import os

def dump_env():
    print('dumping env variables from travis:')
    print(os.getenv('TRAVIS_BRANCH'))
    print(os.getenv('TRAVIS_TAG'))
    print(os.getenv('TRAVIS_PULL_REQUEST'))
    print(os.getenv('TRAVIS_PULL_REQUEST_BRANCH'))

def isMaster():
    val = os.getenv('TRAVIS_BRANCH', 'NOT SET')
    return val == 'master'

def isTag():
    val = os.getenv('TRAVIS_TAG', 'NOT SET')
    return val != 'NOT SET'

def isPullRequest():
    val = os.getenv('TRAVIS_PULL_REQUEST', 'NOT SET')
    return val != 'NOT SET'

if (isMaster()):
    print("publish as :latest")

if (isTag()):
    print("publish as " + os.getenv('TRAVIS_TAG'))

if (isPullRequest()):
    print("publish as " + os.getenv('TRAVIS_PULL_REQUEST_BRANCH'))

  # master:
  #   unspecified/cloud-builders-gcloud-config:latest
  #   gcr.io/un-cloud-builders/build-config:latest
  # tag:
  #   unspecified/cloud-builders-gcloud-config:<tag>
  #   gcr.io/un-cloud-builders/build-config:<tag>
  # pull request:
  #   unspecified/cloud-builders-gcloud-config:<branch>
  #   gcr.io/un-cloud-builders/build-config:<branch>
  # other:

