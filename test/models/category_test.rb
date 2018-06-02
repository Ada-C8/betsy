require "test_helper"

describe Category do
  let(:c) { Category.new(name: "Test") }

  describe 'validations' do
    it 'can be valid' do
      c.must_be :valid?
    end

    describe 'name' do
      it 'must be present' do
        c.name.clear

        c.wont_be :valid?
        c.errors.messages.must_include :name
      end

      it 'must be unique' do
        d = c.dup
        d.save

        c.wont_be :valid?
        c.errors.messages.must_include :name
      end

      it 'tests uniqueness - case sensitive' do
        d = Category.new(name: "TEST")
        d.save

        c.wont_be :valid?
        c.errors.messages.must_include :name
      end
    end
  end

  describe 'relationships' do
    it 'responds to products' do
      c.must_respond_to :products
    end
  end
end
