defmodule FileDownloader do
  def download_file(day, session_cookie) do
    url = "https://adventofcode.com/2023/day/#{day}/input"
    headers = [{"Cookie", "session=#{session_cookie}"}]

    response = HTTPoison.get!(url, headers)

    # Ensure the inputs directory exists
    File.mkdir_p("inputs")

    # Write the response body to a file
    File.write!("inputs/day#{day}.txt", response.body)
  end
end
