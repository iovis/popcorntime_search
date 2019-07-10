require 'spec_helper'

describe PopcorntimeSearch::Link do
  subject         { build(:link) }
  let(:show_link) { build(:link, :show) }

  describe '#info_hash' do
    it 'properly extracts the info hash' do
      expect(subject.info_hash).to   eq '5e915039c619366e490d08db3ffed21f3a3ae84a'
      expect(show_link.info_hash).to eq 'a9a56daf4339e7f098c35cf64d4ddfa8b9f95364'
    end
  end

  describe '#filename' do
    context "when the magnet link contains the 'dn' key" do
      it 'properly extracts the filename' do
        expect(show_link.filename).to eq 'Game.of.Thrones.S06E03.1080p.HDTV.x264-BATV[ettv]'
      end
    end

    context "when the magnet link doesn't the 'dn' key" do
      it 'returns nil' do
        expect(subject.filename).to be_nil
      end
    end
  end

  describe '#to_s' do
    before :each do
      require 'highline'
      HighLine.colorize_strings
    end

    it 'includes the title' do
      expect(subject.to_s).to include 'The Godfather'
    end

    it 'includes the quality' do
      expect(subject.to_s).to include '[1080p]'
    end

    it 'includes the language' do
      expect(subject.to_s).to include '[EN]'
    end

    it 'includes the provider' do
      expect(subject.to_s).to include '[YTS]'
    end

    it 'includes the seeders' do
      expect(subject.to_s).to include '1007'
    end

    it 'includes the leechers' do
      expect(subject.to_s).to include '132'
    end

    context 'when given a size' do
      it 'includes the size' do
        expect(subject.to_s).to include '(2.40 GB)'
      end
    end

    context 'when not given a size' do
      it 'does not includes the size' do
        expect(show_link.to_s).not_to match(/\s\(\d+\.\d+ (K|M|G)B\)/)
      end
    end
  end
end
