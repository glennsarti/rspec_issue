require 'spec_helper'

describe 'testmodule' do

  # ------------------------------------------- Just using notify resources

  # This expectation succeeds
  it { is_expected.to compile }

  # This expectation succeeds
  it { is_expected.to contain_notify('notify1') }

  # This expectation succeeds
  it { is_expected.to contain_notify('notify2') }

  # This expectation fails!
  it { is_expected.to contain_notify('notify2').that_requires(["Notify['notify1']"]) }

  # Even with an explicit cataloge compile, this expectation fails!
  it {
    is_expected.to compile

    is_expected.to contain_notify('notify2').that_requires(["Notify['notify1']"])
  }
  it {
    is_expected.to compile.with_all_deps

    is_expected.to contain_notify('notify2').that_requires(["Notify['notify1']"])
  }

  # ------------------------------------------- Using the custom Dummy type
  it { is_expected.to contain_dummy('Test') }

  # This expectation fails!
  # Also note that the '!!!!! Autorequire for Dummy Type called for the test below' is never output so
  # Autorequires is NEVER called
  it { is_expected.to contain_notify('Test').that_requires(["Notify['notify1']"]) }

  # Even with an explicit cataloge compile, this expectation fails!
  it {
    is_expected.to compile

    is_expected.to contain_notify('Test').that_requires(["Notify['notify1']"])
  }
  it {
    is_expected.to compile.with_all_deps

    is_expected.to contain_notify('Test').that_requires(["Notify['notify1']"])
  }
end

# Example output
# C:\Source\tmp\rspec-issue> be rspec -f d spec/classes

# testmodule
# !!!!! Autorequire for Dummy Type called for the test below
#   should compile into a catalogue without dependency cycles
#   should contain Notify[notify1]
#   should contain Notify[notify2]
#   should contain Notify[notify2] that requires Notify['notify1'] (FAILED - 1)
# !!!!! Autorequire for Dummy Type called for the test below
#   should contain Notify[notify2] that requires Notify['notify1'] (FAILED - 2)
# !!!!! Autorequire for Dummy Type called for the test below
#   should contain Notify[notify2] that requires Notify['notify1'] (FAILED - 3)
#   should contain Dummy[Test]
#   should contain Notify[Test] that requires Notify['notify1'] (FAILED - 4)
# !!!!! Autorequire for Dummy Type called for the test below
#   should contain Notify[Test] that requires Notify['notify1'] (FAILED - 5)
# !!!!! Autorequire for Dummy Type called for the test below
#   should contain Notify[Test] that requires Notify['notify1'] (FAILED - 6)

# Failures:

#   1) testmodule should contain Notify[notify2] that requires Notify['notify1']
#      Failure/Error: it { is_expected.to contain_notify('notify2').that_requires(["Notify['notify1']"]) }
#        expected that the catalogue would contain Notify[notify2] with that requires Notify['notify1']
#      # ./spec/classes/testmodule_spec.rb:17:in `block (2 levels) in <top (required)>'

#   2) testmodule should contain Notify[notify2] that requires Notify['notify1']
#      Failure/Error: is_expected.to contain_notify('notify2').that_requires(["Notify['notify1']"])
#        expected that the catalogue would contain Notify[notify2] with that requires Notify['notify1']
#      # ./spec/classes/testmodule_spec.rb:23:in `block (2 levels) in <top (required)>'

#   3) testmodule should contain Notify[notify2] that requires Notify['notify1']
#      Failure/Error: is_expected.to contain_notify('notify2').that_requires(["Notify['notify1']"])
#        expected that the catalogue would contain Notify[notify2] with that requires Notify['notify1']
#      # ./spec/classes/testmodule_spec.rb:28:in `block (2 levels) in <top (required)>'

#   4) testmodule should contain Notify[Test] that requires Notify['notify1']
#      Failure/Error: it { is_expected.to contain_notify('Test').that_requires(["Notify['notify1']"]) }
#        expected that the catalogue would contain Notify[Test]
#      # ./spec/classes/testmodule_spec.rb:35:in `block (2 levels) in <top (required)>'

#   5) testmodule should contain Notify[Test] that requires Notify['notify1']
#      Failure/Error: is_expected.to contain_notify('Test').that_requires(["Notify['notify1']"])
#        expected that the catalogue would contain Notify[Test]
#      # ./spec/classes/testmodule_spec.rb:41:in `block (2 levels) in <top (required)>'

#   6) testmodule should contain Notify[Test] that requires Notify['notify1']
#      Failure/Error: is_expected.to contain_notify('Test').that_requires(["Notify['notify1']"])
#        expected that the catalogue would contain Notify[Test]
#      # ./spec/classes/testmodule_spec.rb:46:in `block (2 levels) in <top (required)>'

# Finished in 1.07 seconds (files took 2.9 seconds to load)
# 10 examples, 6 failures

# Failed examples:

# rspec ./spec/classes/testmodule_spec.rb:17 # testmodule should contain Notify[notify2] that requires Notify['notify1']
# rspec ./spec/classes/testmodule_spec.rb:20 # testmodule should contain Notify[notify2] that requires Notify['notify1']
# rspec ./spec/classes/testmodule_spec.rb:25 # testmodule should contain Notify[notify2] that requires Notify['notify1']
# rspec ./spec/classes/testmodule_spec.rb:35 # testmodule should contain Notify[Test] that requires Notify['notify1']
# rspec ./spec/classes/testmodule_spec.rb:38 # testmodule should contain Notify[Test] that requires Notify['notify1']
# rspec ./spec/classes/testmodule_spec.rb:43 # testmodule should contain Notify[Test] that requires Notify['notify1']
