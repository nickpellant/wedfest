require 'rails_helper'

RSpec.describe ImportInvitesCsv, type: :service do
  subject(:import_invites_csv) { described_class.new(csv_content: csv_content) }

  let(:csv_content) do
    File.open(
      Rails.root.join(
        'spec/support/fixtures/csv_imports/invites/valid_csv.csv'
      )
    ).read
  end

  describe '#call' do
    subject(:call) { import_invites_csv.call }

    let(:first_created_invite) { Invite.find_by(name: 'Jones Family') }
    let(:second_created_invite) { Invite.find_by(name: 'Sam & Sarah') }
    let(:third_created_invite) { Invite.find_by(name: 'Ben, Hermione & Jack') }

    it 'creates the Invites' do
      expect { call }.to change { Invite.count }.from(0).to(3)

      expect(first_created_invite.invite_code).to_not be_empty
      expect(second_created_invite.invite_code).to_not be_empty
      expect(third_created_invite.invite_code).to_not be_empty
    end
  end
end
