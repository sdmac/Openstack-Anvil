# vim: tabstop=4 shiftwidth=4 softtabstop=4

#    Copyright (C) 2012 Yahoo! Inc. All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

from anvil import components as comp


class GlanceClientInstaller(comp.PythonInstallComponent):
    def _filter_pip_requires(self, fn, lines):
        return [l for l in lines if l.lower().find('keystoneclient') == -1]


class GlanceClientTester(comp.PythonTestingComponent):
    def _use_run_tests(self):
        return False

    def _get_test_exclusions(self):
        return [
            # These seem to require swift, not always installed...
            'test_ssl_cert_mismatch',
            'test_ssl_cert_subject_alt_name',
        ]
