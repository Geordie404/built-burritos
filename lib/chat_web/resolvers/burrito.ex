defmodule ChatWeb.Resolvers.Burrito do
  alias Chat.Burrito

# get all burritos from base schema
  def list_burritos(_args, _context) do
    {:ok, Burrito.get_all_burritos()}
  end

  def list_burritos(_args, _context) do
    {:ok, Burrito.gql_burritos()}
  end

end
