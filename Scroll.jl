module Scroll

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export scrollarea

Genie.Renderer.Html.register_normal_element("q__scroll__area", context = @__MODULE__)

function scrollarea(args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__scroll__area(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
