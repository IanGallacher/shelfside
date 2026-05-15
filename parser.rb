require 'csv'

filename = ARGV[0]

csv = CSV.open(filename)
headers = csv.readline.map(&:strip)

counts = Hash.new { |hash, key| hash[key] = Hash.new(0) }

def generate_file(csv_row)
  score = csv_row["#{csv_row["Reviewed By"]}'s score"]

  <<~FILE
    ---
    title: "#{csv_row["name"]}"
    game_name: "#{csv_row["name"]}"
    id: "#{csv_row["id"]}"
    date: "#{csv_row["date publish"]}"
    reviewer: "#{csv_row["Reviewed By"]}"
    shelfside_certified: "#{csv_row["Shelfside Certified"]}"
    video_link: "#{"Vid Link"}"
    score: #{score != "N/A" ? score : ""}
    scores:
      shelfside: #{csv_row["Shelfside's Score"]}
      daniel: #{csv_row["Daniel's score"]}
      ashton: #{csv_row["Ashton's score"]}
      pranav: #{csv_row["Pranav's Score"]}
      alexander: #{csv_row["Alexander's Score"]}
    excerpt: ""
    ---
    
  FILE
end

csv.each do |row|
  game = {}
  row.each_with_index do |value, index|
    key = headers[index]
    game[key] = value
  end

  File.open("_reviews/#{game["name"].strip.tr(" ","_")}.md", "w") do |file|
    file << generate_file(game)
  end
end
