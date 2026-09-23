# frozen_string_literal: true

Facter.add(:keyaccess_version) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  setcode do
    # dpkg-query --showformat='${Version}' --show keyaccess
    Facter::Core::Execution.execute("/usr/bin/dpkg-query --showformat='${Version}' --show keyaccess")
  end
end
