module Img
using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export img

Genie.Renderer.Html.register_normal_element("q__img", context = @__MODULE__)

function img(args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__img(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
