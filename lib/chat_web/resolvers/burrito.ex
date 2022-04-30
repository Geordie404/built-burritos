defmodule ChatWeb.Resolvers.Burrito do
  alias Chat.Burrito


  def list_burritos(_args, _context) do
    {:ok, Burrito.get_all_burritos()}
  end

end
