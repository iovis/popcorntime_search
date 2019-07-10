require 'spec_helper'

describe PopcorntimeSearch::ShowResult do
  let(:base_url) { PopcorntimeSearch::BASE_URL }

  subject { build(:show_result) }

  describe '#links' do
    before :each do
      stub_request(:get, "#{base_url}/show/tt0944947")
        .to_return(File.new('spec/support/http_stubs/show_detail.http'))
    end

    it 'should return a list of Links' do
      expect(subject.links.count).to eq 3
      expect(subject.links).to all be_a PopcorntimeSearch::Link

      link = subject.links.first
      expect(link.title).to    eq 'Game of Thrones 6x03'
      expect(link.language).to eq 'en'
      expect(link.quality).to  eq '1080p'
    end

    context 'when given an nonexistent episode' do
      subject { build(:show_result, :nonexistent).links }

      it 'should return an empty list' do
        is_expected.to be_empty
      end
    end
  end
end
