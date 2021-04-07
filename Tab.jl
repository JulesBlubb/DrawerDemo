module Tab

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export tab, tabs, tab_panels, tab_panel

Genie.Renderer.Html.register_normal_element("q__tabs", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__tab", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__tab__panel", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__tab__panels", context = @__MODULE__)


function tabs(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    q__tabs(args...; kwargs...)
  end
end


function tab_panels(args...; kwargs...)
  q__tab__panels(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

function tab_panel(args...; kwargs...)
  q__tab__panel(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

function tab(args...; kwargs...)
  q__tab(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end
