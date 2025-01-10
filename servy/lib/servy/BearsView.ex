defmodule Servy.BearsView do
  @templates_path Path.expand("../../Templates",__DIR__)
  require EEx
  EEx.function_from_file(:def,:index,Path.join(@templates_path,"index.eex"),[:bears])
  EEx.function_from_file(:def,:show,Path.join(@templates_path,"show.eex"),[:bears])


end
