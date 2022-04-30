defmodule ChatWeb.Resolvers.Burrito do
  alias Chat.Burrito

# get all burritos from base schema
  def list_burritos(_args, _context) do
    #uses schema get_all_burritos function to query
    {:ok, Burrito.get_all_burritos()}
  end

  def named_burritos(args, _context) do
    #get name out of map
    %{name: name} = args
    #uses schema get_user_burritos function to query
    {:ok, Burrito.get_user_burritos(name)}
  end

end
