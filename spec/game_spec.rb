require 'spec_helper'

module Mastermind
  describe 'Game' do
    context '#code_generator' do
      it "create's a code with a random value" do
        expect(inititialize).to have_at_least(1).things
      end
    end
  end
end