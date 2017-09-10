require 'spec_helper'

RSpec.describe PopcorntimeSearch::Link do
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
end
