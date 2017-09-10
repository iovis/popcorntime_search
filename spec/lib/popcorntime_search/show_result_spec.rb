require 'spec_helper'

RSpec.describe PopcorntimeSearch::ShowResult do
  subject { build(:show_result) }
  let(:base_url) { PopcorntimeSearch::BASE_URL }

  describe '#links' do
    it 'should return a list of Links' do
      stub_request(:get, "#{base_url}/show/tt0944947")
        .to_return(File.new('spec/support/http_stubs/show_detail.http'))

      expect(subject.links.count).to eq 3
      expect(subject.links).to all be_a PopcorntimeSearch::Link

      link = subject.links.first
      expect(link.title).to    eq 'Game of Thrones 6x03'
      expect(link.language).to eq 'en'
      expect(link.quality).to  eq '1080p'
    end
  end
end
