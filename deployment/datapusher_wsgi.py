import os
import sys
import hashlib

# activate_this = os.path.join('/usr/lib/ckan/datapusher/bin/activate_this.py')
# with open(activate_this) as fp:
#     exec(fp.read(), dict(__file__=activate_this))

import ckanserviceprovider.web as web
web.init()

import datapusher.jobs as jobs
assert(jobs.push_to_datastore)

application = web.app


