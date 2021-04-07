module List

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export list, item, expansion_item, item_section, item_label

Genie.Renderer.Html.register_normal_element("q__list", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__expansion__item", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item__section", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item__label", context = @__MODULE__)

function list(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    q__list(args...; kwargs...)
  end
end


function item(args...; kwargs...)
  q__item(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

function expansion_item(args...; kwargs...)
  q__expansion__item(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

function item_section(args...; kwargs...)
  q__item__section(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end


function item_label(args...; kwargs...)
  q__item__label(args...; kwargs...)
end

end
