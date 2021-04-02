using Genie, Genie.Renderer.Html, Genie.Router

using Stipple, Stipple.Elements
using StippleUI, StippleUI.Table, StippleUI.Heading, StippleUI.Dashboard, StippleUI.Tab, StippleUI.Separator, StippleUI.Drawer, StippleUI.Layout, StippleUI.Toolbar, StippleUI.Scroll, StippleUI.Avatar, StippleUI.Img
using StippleCharts, StippleCharts.Charts

import StippleUI.Range: range
import Genie.Renderer.Html: select

using DataFrames

const data = DataFrame(Kosten=[44,55,13,43,22], Batterie=[1,2,3,4,5], Haus=[0.1,0.2,0.3,0.4,0.5], PV=[11,12,13,14,15])

const data_opts = DataTableOptions(columns = [Column("Batterie"), Column("Haus", align = :right),
                                              Column("PV", align = :right), Column("Kosten", align = :right)])

const lineplot_dates = DataFrame(test=[[1484505000000,150000000],[1484591400000,160379978],[1484677800000,170493749],[1484764200000,160785250],[1484850600000,167391904],[1484937000000,161576838],[1485023400000, 161413854],[1485109800000,152177211],[1485196200000,140762210],[1485282600000,144381072],[1485369000000,154352310]])

Base.@kwdef mutable struct Dashboard <: ReactiveModel
    cars::R{Vector{String}} = ["Mercedes", "BMW", "Toyota"]
    mercedes::R{String} = "Mercedes"
    car_costs::R{Int} = 1032
    car_profit::R{Int} = 30
    car_price::R{Int} = 4195

    house_costs::R{Int} = 300000
    house_size::R{Int} = 3000

    menu::R{Bool} = false
    click_house::R{Bool} = false
    click_car::R{Bool} = false

    show_start::R{Bool} = true
    show_car::R{Bool} = false
    show_house::R{Bool} = false

    # Piechart
    plot_options::PlotOptions = PlotOptions(chart_type=:pie, chart_width=380,labels= ["Team A", "Team B", "Team C", "Team D", "Team E"])
    piechart::R{Vector{Int}} = [44,55,13,43,22]

    # Line Plot Example
    line_plot_options::PlotOptions = PlotOptions(chart_type=:area, chart_height=250, xaxis_type="datetime")
    linechart::R{Vector{PlotSeries}} = [PlotSeries("xyz", PlotData(lineplot_dates.test))]

    # Table Example
    credit_data::R{DataTable} = DataTable(data, data_opts)
    credit_data_pagination::DataTablePagination = DataTablePagination(rows_per_page=5)
    credit_data_loading::R{Bool} = false
end

function viewHouse(model::M) where {M<:Stipple.ReactiveModel}
    model.menu[] = false
    model.show_car[] = false
    model.show_house[] = true
    model.show_start[] = false
end

function viewCar(model::M) where {M<:Stipple.ReactiveModel}
    model.menu[] = false
    model.show_car[] = true
    model.show_house[] = false
    model.show_start[] = false
end

Stipple.register_components(Dashboard, StippleCharts.COMPONENTS)
model = Dashboard() |> Stipple.init

on(model.click_car) do _
    viewCar(model)
end

on(model.click_house) do _
    viewHouse(model)
end

function ui()
    [
        Stipple.Layout.page(vm(model),[
            StippleUI.Layout.layout(view="lHh LpR lff", class="shadow-2 rounded-borders", [
                header(class="bg-black", [
                    toolbar([
                        btn("",icon="menu", @click("menu = !menu"))
                    ])
                ])
                # hier ist das Menü auf der linken Seite definiert
                drawer(dashedwidth="250", vmodel="menu", class="bg-grey-3", breakpoint="500", [
                    scrollarea( class="fit", style="height: calc(100% - 200px); margin-top: 200px; border-right: 1px solid #ddd", [
                        list([
                            item(btn("Haus", icon="house", class="full-width", @click("click_house = !click_house")))
                            item(btn("Auto", icon="electric_car", class="full-width", @click("click_car = !click_car")))
                        ])
                    ])
                    StippleUI.Img.img(class="absolute-top", src="https://cdn.quasar.dev/img/material.png", style="height: 200px",[
                        Html.div(class="absolute-bottom bg-transparent", [
                            avatar(size="56px", class="q-mb-sm", [
                                StippleUI.Img.img(src="https://cdn.quasar.dev/img/boy-avatar.png")
                            ])
                            Html.div(class="text-weight-bold",["Max"])
                            "@admin"
                        ])
                        #  ])
                    ])
                ])

                template([
                    card([
                        StippleUI.Img.img(src="https://cdn.quasar.dev/img/mountains.jpg")
                        card_section([
                            h6("Welcome to my example")

                        ])
                        card_section(class="q-pt-none",[
                            "This example shows you how to use drawer!"
                        ])
                    ])

                ], v__if=:show_start)

                template([
                    row([
                        # ein Beispiel für die +, copy, - Leiste am oberen Ende
                        tabs(vmodel="tab", dense="", align="justify", [
                            tab(name="add", icon="add")
                            tab(name="copy", icon="content_copy")
                            tab(name="rmv", icon="remove")
                        ])
                        separator()
                        tab_panels(vmodel="tab", animated="",[
                        ])
                    ])
                    expansion_item(label="Costs", caption="3000",[
                        row([
                            cell([
                                h5("Costs")
                                p([
                                    input("", @bind(:car_costs))
                                ])
                            ])
                            cell([
                                h5("Profit")
                                p([
                                    input("", @bind(:car_profit))
                                ])
                            ])
                        ])
                        row([
                            cell([
                                h5("Price")
                                p([
                                    input("", @bind(:car_price))
                                ])
                            ])
                            cell([
                                h5("Brand")
                                p([
                                    select(:mercedes, options=:cars)
                                ])
                            ])
                        ])
                        row([
                            cell(class="st-module", [
                                plot(:linechart; options=:line_plot_options)
                            ])
                        ])
                    ])
                ], v__if=:show_car)

                template([
                    row([
                        cell(class="st-module",[
                            h3("Costs")
                            plot(:piechart; options=:plot_options)
                        ])
                        cell(class="st-module",[
                            h4("Credit")
                            table(:credit_data;
                                  style="height: 400px;",
                                  pagination=:credit_data_pagination,
                                  loading=:credit_data_loading)
                        ])
                    ])
                    row([
                        cell([
                            h5("Costs")
                            p([
                                input("", @bind(:house_costs))
                            ])
                        ])
                            cell([
                                h5("Size")
                                p([
                                    input("", @bind(:house_size))
                                ])
                            ])
                    ])
                ], v__if=:show_house)

            ])
        ])
    ]
end
route("/") do
    ui() |> html
end

up(open_browser=true)
