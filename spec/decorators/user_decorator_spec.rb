# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  let(:admin) { build_stubbed(:user, :admin) }

  describe '#current_allocation' do
    subject(:user) { build_stubbed(:user).decorate }

    let(:allocation) { build_stubbed(:allocation, user: user) }

    before do
      allow(user.model).to receive(:current_allocation).and_return(allocation.project)
      allow(user.h).to receive(:current_user).and_return(admin)
    end

    context 'when the current user is allocated' do
      it 'returns project name' do
        allow(user.h).to receive(:current_user).and_return(user)

        expect(user.current_allocation).to eq(allocation.project)
      end
    end

    context 'when no allocation is set' do
      it 'returns not allocated' do
        allow(user.model).to receive(:current_allocation).and_return(nil)

        expect(user.current_allocation).to eq('Não alocado')
      end
    end
  end

  describe '#level' do
    context 'when level is set' do
      subject(:user) { build_stubbed(:user, level: 'trainee').decorate }

      it 'returns user level' do
        expect(subject.level).to eq('Trainee')
      end
    end

    context 'when level is nil' do
      subject(:user) { build_stubbed(:user, level: nil).decorate }

      it 'returns N/A' do
        expect(subject.level).to eq('N/A')
      end
    end
  end

  describe '#english_level' do
    subject(:user) { build_stubbed(:user).decorate }

    context 'when english_level is set' do
      before { allow_any_instance_of(User).to receive(:english_level).and_return('fluent') }

      it 'returns user english_level' do
        expect(subject.english_level).to eq('Fluent')
      end
    end

    context 'when english_level is nil' do
      before { allow_any_instance_of(User).to receive(:english_level).and_return(nil) }

      it 'returns not evaluated' do
        expect(subject.english_level).to eq('Não avaliado')
      end
    end
  end

  describe '#english_score' do
    subject(:user) { build_stubbed(:user).decorate }

    context 'when english_score is set' do
      before { allow_any_instance_of(User).to receive(:english_score).and_return(8) }

      it 'returns user english_score' do
        expect(subject.english_score).to eq(8)
      end
    end

    context 'when english_score is nil' do
      before { allow_any_instance_of(User).to receive(:english_score).and_return(nil) }

      it 'returns not evaluated' do
        expect(subject.english_score).to eq('Não avaliado')
      end
    end
  end

  describe '#performance_score' do
    subject(:user) { build_stubbed(:user).decorate }

    context 'when performance_score is set' do
      before { allow_any_instance_of(User).to receive(:performance_score).and_return(5) }

      it 'returns user performance_score' do
        expect(subject.performance_score).to eq(5)
      end
    end

    context 'when performance_score is nil' do
      before { allow_any_instance_of(User).to receive(:performance_score).and_return(nil) }

      it 'returns not evaluated' do
        expect(subject.performance_score).to eq('Não avaliado')
      end
    end
  end

  describe '#overall_score' do
    subject(:user) { build_stubbed(:user).decorate }

    context 'when overall_score is set' do
      before { allow_any_instance_of(User).to receive(:overall_score).and_return(2) }

      it 'returns user overall_score' do
        expect(subject.overall_score).to eq(2)
      end
    end

    context 'when overall_score is nil' do
      before { allow_any_instance_of(User).to receive(:overall_score).and_return(nil) }

      it 'returns not evaluated' do
        expect(subject.overall_score).to eq('Não avaliado')
      end
    end
  end

  describe '#office_head_name' do
    subject(:user) { build_stubbed(:user).decorate }

    context 'when office head is set' do
      let(:office_with_head) { build(:office, :with_head) }
      before { allow_any_instance_of(User).to receive(:office).and_return(office_with_head) }

      it 'returns office head name' do
        expect(subject.office_head_name).to eq(office_with_head.head.name)
      end
    end

    context 'when office head is nil' do
      let(:office_without_head) { build(:office) }
      before { allow_any_instance_of(User).to receive(:office).and_return(office_without_head) }

      it 'returns N/A' do
        expect(subject.office_head_name).to eq('N/A')
      end
    end
  end
end
