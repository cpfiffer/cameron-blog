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
        pages[i] = replace(pages[i], r"\.md$" => "")
        dt = pagevar(pages[i], :date)
        push!(dates, dt)
    end

    # Print some debugging info
    println("pages: ", pages)
    println("dates: ", dates)

    # sort by date
    pages = sort!(pages, by=x -> string_to_date(pagevar(x, :date)), rev=true)

    return pages_to_list(pages)
    # return list_pages_by_date(pages)
end

"""
Accepts a vector like

["posts/good-book", "posts/information-theory", "posts/julia-1.11", "posts/juliacon-2023"]

and converts it into HTML list items.

Titles are retrieved from `pagevar(path, :title)`.
"""
function pages_to_list(pages)
    io = IOBuffer()
    for page in pages
        title = pagevar(page, :title)
        date = pagevar(page, :date)
        println(io, "<li>")
        println(io, "<span class=\"date\">$date</span>")
        println(io, "<a href=\"/$page\">$title</a>")
        println(io, "</li>")
    end
    return String(take!(io))
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
