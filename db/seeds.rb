
# db/seeds.rb (append)


WeddingGroup.create!([
                       {
                         name: "Smith-Jones Wedding",
                         wedding_date: Date.new(2024, 9, 14),
                         location: "Central Park, New York"
                       },
                       {
                         name: "Lee-Chen Celebration",
                         wedding_date: Date.new(2024, 10, 21),
                         location: "Golden Gate Park, San Francisco"
                       },
                       {
                         name: "Patel-Garcia Union",
                         wedding_date: Date.new(2025, 5, 3),
                         location: "Hyde Park, London"
                       }
                     ])
