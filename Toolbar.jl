module Toolbar

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export toolbar

Genie.Renderer.Html.register_normal_element("q__toolbar", context = @__MODULE__)

function toolbar(args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__toolbar(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
