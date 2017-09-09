require 'spec_helper'

RSpec.describe PopcorntimeSearch::Search do
  let(:base_uri)     { 'https://tv-v2.api-fetch.website' }
  let(:movie_search) { build(:search, :movie) }
  subject            { build(:search) }

  describe 'when passed a search string' do
    it_behaves_like 'a search',
                    'Game of Thrones S06E03',
                    'Game of Thrones', 6, 3, :show

    it_behaves_like 'a search',
                    'BoJack Horseman - 01x07',
                    'BoJack Horseman', 1, 7, :show

    it_behaves_like 'a search',
                    'game of thrones s06e03',
                    'game of thrones', 6, 3, :show

    it_behaves_like 'a search',
                    'Frasier 1x06',
                    'Frasier', 1, 6, :show

    it_behaves_like 'a search',
                    'Mr. Robot S02E01',
                    'Mr. Robot', 2, 1, :show

    it_behaves_like 'a search',
                    "It's Always Sunny in Philadelphia s04e01",
                    "It's Always Sunny in Philadelphia", 4, 1, :show

    it_behaves_like 'a search',
                    'The Godfather II',
                    'The Godfather II', nil, nil, :movie

    it_behaves_like 'a search',
                    'terminator 2',
                    'terminator 2', nil, nil, :movie
  end

  describe '#results' do
    context 'when searching for a TV show' do
      it 'should request the shows api' do
        request = stub_request(:get, "#{base_uri}/shows/1").with(query: { keywords: 'game of thrones' })
        subject.results
        expect(request).to have_been_made.once
      end
    end

    context 'when searching for a movie' do
      it 'should request the shows api' do
        request = stub_request(:get, "#{base_uri}/movies/1").with(query: { keywords: 'the godfather' })
        movie_search.results
        expect(request).to have_been_made.once
      end
    end
  end

  describe '#results_found?' do
    context 'with a socket error' do
      it 'should return false' do
        stub_request(:get, "#{base_uri}/shows/1")
          .with(query: { keywords: 'game of thrones' })
          .to_raise(SocketError)

        expect(subject).not_to be_results_found
      end
    end

    context 'with no results found' do
      it 'should return false' do
        stub_request(:get, "#{base_uri}/shows/1")
          .with(query: { keywords: 'game of thrones' })
          .to_return(File.new('spec/support/http_stubs/failure_search.http'))

        expect(subject).not_to be_results_found
      end
    end

    context 'with results found' do
      it 'should return true' do
        stub_request(:get, "#{base_uri}/shows/1")
          .with(query: { keywords: 'game of thrones' })
          .to_return(File.new('spec/support/http_stubs/show_search.http'))

        expect(subject).to be_results_found
      end
    end
  end
end
