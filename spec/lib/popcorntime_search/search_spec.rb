require 'spec_helper'

RSpec.describe PopcorntimeSearch::Search do
  subject            { build(:search) }
  let(:movie_search) { build(:search, :movie) }
  let(:base_uri)     { PopcorntimeSearch::BASE_URL }

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
    context 'when results were found' do
      context 'and the results are movies' do
        it 'should return instances of MovieResult' do
          stub_request(:get, "#{base_uri}/movies/1")
            .with(query: { keywords: 'the godfather' })
            .to_return(File.new('spec/support/http_stubs/movie_search.http'))

          expect(movie_search.results.count).to eq 3
          expect(movie_search.results.first).to be_a PopcorntimeSearch::MovieResult
        end
      end

      context 'and the results are shows' do
        it 'should return instances of ShowResult' do
          stub_request(:get, "#{base_uri}/shows/1")
            .with(query: { keywords: 'game of thrones' })
            .to_return(File.new('spec/support/http_stubs/show_search.http'))

          result = subject.results.first

          expect(subject.results.count).to eq 1
          expect(result).to be_a PopcorntimeSearch::ShowResult
          expect(result.season).to  eq 6
          expect(result.episode).to eq 3
        end
      end
    end

    context 'when no results were found' do
      it 'should return an empty list' do
        stub_request(:get, "#{base_uri}/shows/1")
          .with(query: { keywords: 'game of thrones' })
          .to_return(File.new('spec/support/http_stubs/failure_search.http'))

        expect(subject.results).to be_empty
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
