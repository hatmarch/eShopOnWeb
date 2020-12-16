#!/bin/bash

set -euxo pipefail

oc whoami
oc whoami --show-server
oc projects
oc project