require 'rspec'
require_relative '../../classes/items/item'

describe Item do
  let(:publish_date) { Date.new(2023, 1, 1) }
  let(:item) { Item.new(publish_date) }
  let(:itemOne) { Item.new('21/11/2012') }
  let(:itemTwo) { Item.new('13/09/2020') }

  describe '#add_genre' do
    it 'should set the genre attribute' do
      item.add_genre('Science Fiction')
      expect(item.genre).to eq('Science Fiction')
    end
  end

  describe '#add_author' do
    it 'should add the item to the author' do
      author = double('Author', items: [])
      allow(author).to receive(:items=)
      item.add_author(author)
      expect(author.items).to include(item)
    end
  end

  describe '#add_label' do
    it 'should set the label attribute and add the item to the label' do
      label = double('Label', add_item: nil)
      item.add_label(label)
      expect(item.label).to eq(label)
      expect(label).to have_received(:add_item).with(item)
    end
  end

  describe '#add_source' do
    it 'should add the item to the source' do
      source = double('Source', items: [])
      allow(source).to receive(:items=)
      item.add_source(source)
      expect(source.items).to include(item)
    end
  end

  it 'should return true for can_be_archived method for itemOne' do
    expect(itemOne.can_be_archived?).to eq(true)
  end

  it 'should set the archived property of itemOne to true' do
    itemOne.move_to_archive
    expect(itemOne.archived).to eq(true)
  end

  it 'should return false for can_be_archived method for itemTwo' do
    expect(itemTwo.can_be_archived?).to eq(false)
  end

  it 'should not change the archived property of itemTwo' do
    itemTwo.move_to_archive
    expect(itemOne.archived).to be_nil
  end
end
