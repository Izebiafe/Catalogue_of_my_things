require 'rspec'
require_relative '../../classes/items/item'

describe Item do
  let(:itemOne) { Item.new('21/11/2012') }
  let(:itemTwo) { Item.new('13/09/2020') }

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
