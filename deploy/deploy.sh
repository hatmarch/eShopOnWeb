#!/bin/bash

set -euxo pipefail

oc whoami
oc whoami --show-server
oc cluster-info