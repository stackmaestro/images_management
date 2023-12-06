# frozen_string_literal: true

require_relative 'image_manager'

RSpec.describe '#image_manager' do
  context 'when given a valid input' do
    let(:valid_input) do
      "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03"
    end

    it 'does not raise any errors' do
      expect { image_manager(valid_input) }.not_to raise_error
    end

    it 'prints the correct output' do
      expected_output = ['Krakow2.jpg',
                         'London1.png',
                         'Krakow1.png',
                         'Florianopolis2.jpg',
                         'Florianopolis1.jpg',
                         'London2.jpg']
      expect(image_manager(valid_input)).to eq(expected_output)
    end
  end

  context 'when given an invalid input' do
    let(:invalid_input) do 
       "photo.jpg, Krakow, 2030-09-05 14:08:15
Mike.png, London, 2040-06-20 15:13:22"
    end

    it 'raises an error' do
      expect { image_manager(invalid_input) }.to raise_error(RuntimeError, /Invalid input:/)
    end
  end
end
