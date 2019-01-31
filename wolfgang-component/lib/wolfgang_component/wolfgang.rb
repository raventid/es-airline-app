# Entity user guide: http://docs.eventide-project.org/user-guide/entities.html
# Entity snapshotting user guide: http://docs.eventide-project.org/user-guide/entity-store/snapshotting.html

module WolfgangComponent
  class Wolfgang
    include Schema::DataStructure

    attribute :id, String
    attribute :sequence, Integer

    def processed?(message_sequence)
      return false if sequence.nil?

      sequence >= message_sequence
    end

    # TODO Implement attributes
    # TODO Implement entity logic, predicates, mutations, calculations, etc
    # Note: This class's methods should pertain only to its attributes
  end
end
