function hfun_bar(vname)
    val = Meta.parse(vname[1])
    return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
    var = vname[1]
    return pagevar("index", var)
end

function lx_baz(com, _)
    # keep this first line
    brace_content = Franklin.content(com.braces[1]) # input string
    # do whatever you want here
    return uppercase(brace_content)
end

string_to_date(s::Nothing) = Date("2000-01-01", "yyyy-mm-dd")
string_to_date(d::Date) = d
string_to_date(s) = Date(s, "yyyy-mm-dd")

function hfun_list_posts(folders)
    @info "" folders
    pages = String[]
    dates = []
    root = Franklin.PATHS[:folder]
    for folder in folders
        startswith(folder, "/") && (folder = folder[2:end])
        cd(root) do
            foreach(((r, _, fs),) -> append!(pages, joinpath.(r, fs)), walkdir(folder))
        end # do
    end
    filter!(x -> endswith(x, ".md"), pages)
    for i in eachindex(pages)
        @info pages[i]
        dt1 = pagevar(pages[i], :date)
        pages[i] = replace(pages[i], r"\.md$" => "")

        # Get the date
        dt = pagevar(pages[i], :date)

        @info "" dt dt1
        push!(dates, dt)
    end

    # Print some debugging info
    println("pages: ", pages)
    println("dates: ", dates)

    # sort by date
    pages = sort!(pages, by=x -> string_to_date(pagevar(x, :date)), rev=true)

    # Make the buffer
    io = IOBuffer()
    for i in eachindex(pages)
        title = pagevar(pages[i], :title)
        date = pagevar(pages[i], :date)
        page = pages[i]
        @info "Page $i" title date page
        println(io, "<li>")
        println(io, "<span class=\"date\">$date</span>")
        println(io, "<a href=\"/$page\">$title</a>")
        println(io, "</li>")
    end

    # function pages_to_list(pages)
    #     io = IOBuffer()
    #     for page in pages
    #         title = pagevar(page, :title)
    #         date = pagevar(page, :date)
    #         println(io, "<li>")
    #         println(io, "<span class=\"date\">$date</span>")
    #         println(io, "<a href=\"/$page\">$title</a>")
    #         println(io, "</li>")
    #     end
    #     return String(take!(io))
    # end


    final_string = String(take!(io))
    println(final_string)
    return final_string
end

"""
    hfun_pretty_date(vname)

Returns a pretty date string.
"""
function hfun_pretty_date(vname)
    date_string = pagevar(vname[1], :date)
    if isnothing(date_string)
        return "No date"
    end
    date = Dates.Date(date_string)
    return Dates.format(date, "d u yyyy")
end
