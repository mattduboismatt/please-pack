module Mutations
  SavePicks = GraphQL::Relay::Mutation.define do
    name "SavePicks"

    input_field :entry_id, !types.ID
    input_field :contestant_ids, !types[types.ID]

    return_field :picks, types[Queries::PickType]

    resolve ->(inputs, _context) do
      entry = Entry.find(inputs[:entry_id])
      contestant_ids = inputs[:contestant_ids]

      entry.picks.excluding_contestants(contestant_ids).destroy_all

      picks = contestant_ids.map do |contestant_id|
        Pick.find_or_create_by!(entry: entry, contestant_id: contestant_id)
      end

      {
        picks: picks
      }
    end
  end
end
