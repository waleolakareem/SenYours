require 'rails_helper'

RSpec.describe Appointment, type: :model do
  #before(:all) do
    #@companion = create(:companion)
    #@senior = create(:senior)
    #let(:appointment) { Appointment.create(senior_id: @senior.id, companion_id: @companion.id) }
  #end

  describe "associations" do
    it { should belong_to(:senior).class_name('User') }
    it { should belong_to(:companion).class_name('User') }
  end
end
