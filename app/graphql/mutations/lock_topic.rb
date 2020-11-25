module Mutations
  class LockTopic < GraphQL::Schema::Mutation
    argument :id, ID, required: true

    description "Lock a topic in community."

    field :success, Boolean, null: false

    def resolve(params)
      mutator = LockTopicMutator.new(context, params)

      if mutator.valid?
        mutator.lock_topic
        mutator.notify(:success, "Done!", "Topic locked successfully!")
        { success: true }
      else
        mutator.notify_errors
        { success: false }
      end
    end
  end
end
