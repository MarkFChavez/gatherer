require 'rails_helper'

RSpec.describe CreatesProject do
  it "creates a project given a name" do
    creator = CreatesProject.new(name: "Project Runway")
    creator.build
    
    expect(creator.project.name).to eq "Project Runway"
  end

  describe "task string parsing" do
    let(:creator) { CreatesProject.new(name: "Test", task_string: task_string) }
    let(:tasks) { creator.convert_string_to_tasks }

    describe "with an empty string" do
      let(:task_string) { "" }

      it "handles an empty string" do
        expect(tasks.size).to eq 0
      end
    end

    describe "with a single string" do
      let(:task_string) { "Start things" }

      it "handles a single string" do
        expect(tasks.size).to eq 1
        expect(tasks.map(&:title)).to eq ["Start things"]
        expect(tasks.map(&:size)).to eq [1]
      end
    end

    describe "with a single string with size" do
      let(:task_string) { "Start things:3" }

      it "handles a single string with size" do
        expect(tasks.size).to eq 1
        expect(tasks.map(&:title)).to eq ["Start things"]
        expect(tasks.map(&:size)).to eq [3]
      end
    end

    describe "with multiple tasks" do
      let(:task_string) { "Start things:3\nEnd things:2" }

      it "handles multiple tasks" do
        expect(tasks.size).to eq 2
        expect(tasks.map(&:title)).to eq ["Start things", "End things"]
        expect(tasks.map(&:size)).to eq [3, 2]
      end
    end

    describe "attaching tasks to the project" do
      let(:task_string) { "Start things:3\nEnd things:2" }

      it "saves the project and tasks" do
        creator.create

        expect(creator.project.tasks.size).to eq 2
        expect(creator.project).not_to be_a_new_record
      end
    end
  end
end
