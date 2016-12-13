require 'spec_helper'

package_list = %w(
  squid
  libtool-ltdl
)

if amazon?
  describe 'Packages' do
    it 'Squid Packages Installed' do
      package_list.each do |package|
        expect(package(package)).to be_installed
      end
    end
  end
end
