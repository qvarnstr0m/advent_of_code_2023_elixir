defmodule Mix.Tasks.FetchInput do
  use Mix.Task

  @shortdoc "Fetches input data for a specified day with given session cookie"
  def run(argv) do

    Mix.Task.run("app.start")

    [day, session_cookie] = argv

    if day && session_cookie do
      FileDownloader.download_file(day, session_cookie)
    else
      Mix.shell().info("Usage: mix fetch_input <day> <session_cookie>")
    end
  end
end
