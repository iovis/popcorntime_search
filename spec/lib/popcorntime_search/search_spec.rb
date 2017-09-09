require 'spec_helper'

RSpec.shared_examples 'a search' do |search_string, title, season, episode, kind|
  context "with #{search_string}" do
    let(:search) { described_class.new(search_string) }

    it 'parses the title' do
      expect(search.title).to eq(title)
    end

    it 'parses the season' do
      expect(search.season).to eq(season)
    end

    it 'parses the episode' do
      expect(search.episode).to eq(episode)
    end

    it 'determines the kind' do
      expect(search.kind).to eq(kind)
    end
  end
end

RSpec.describe PopcorntimeSearch::Search do
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
end
