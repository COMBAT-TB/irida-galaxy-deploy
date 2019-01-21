#!/usr/bin/env python

import os
from bioblend import galaxy
admin_email = os.environ.get('GALAXY_DEFAULT_ADMIN_USER', 'admin@galaxy.org')
admin_pass = os.environ.get('GALAXY_DEFAULT_ADMIN_PASSWORD', 'admin')
url = "http://localhost:8080"
gi = galaxy.GalaxyInstance(url=url, email=admin_email, password=admin_pass)

wf = galaxy.workflows.WorkflowClient(gi)
wf.import_workflow_from_local_path('/shed_tools/testtoolshed.g2.bx.psu.edu/repos/sanbi-uwc/sanbi_freebayes_variant_calling/31dec9fabb7e/sanbi_freebayes_variant_calling/SANBI_freebayes_variant_call.ga')
