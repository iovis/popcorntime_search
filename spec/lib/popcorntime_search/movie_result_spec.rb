require 'spec_helper'

describe PopcorntimeSearch::MovieResult do
  subject        { build(:movie_result) }
  let(:base_url) { PopcorntimeSearch::BASE_URL }

  describe '#links' do
    it 'should return a list of Links' do
      stub_request(:get, "#{base_url}/movie/tt0068646")
        .to_return(File.new('spec/support/http_stubs/movie_detail.http'))

      expect(subject.links.count).to eq 2
      expect(subject.links).to all be_a PopcorntimeSearch::Link

      link = subject.links.first
      expect(link.title).to    eq 'The Godfather'
      expect(link.language).to eq 'en'
      expect(link.quality).to  eq '1080p'
    end
  end
end
