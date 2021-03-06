#
# Copyright 2015, SUSE LINUX Products GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "spec_helper"

describe ::Crowbar::Checks::Maintenance do
  subject { ::Crowbar::Checks::Maintenance }

  context "with maintenance updates installed" do
    it "succeeds" do
      expect(subject.updates_status[:passed]).to be true
    end
  end

  context "with no maintenance updates installed" do
    it "fails" do
      # override global allow from spec_helper
      allow(::Crowbar::Checks::Maintenance).to(
        receive(:updates_status).
        and_return(passed: false, errors: ["Some Error"])
      )
      expect(subject.updates_status[:passed]).to be false
      expect(subject.updates_status[:errors]).to eq(["Some Error"])
    end
  end
end
