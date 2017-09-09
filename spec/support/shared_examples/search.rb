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

