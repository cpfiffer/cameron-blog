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
    posts = []
    for folder in folders
        for file in readdir(folder, join=true)
            if endswith(file, ".md")
                # Get title and date
                title = pagevar(file, :title)
                date = string_to_date(pagevar(file, :date))
                if isnothing(title)
                    @warn "No title found in $file, trying to use # line"

                    # Try to find the first line that starts with "# "
                    open(file) do f
                        for line in eachline(f)
                            if startswith(line, "# ")
                                title = replace(line, r"^# " => "")
                                break
                            end
                        end
                    end

                    if isnothing(title)
                        @warn "No title found in $file"
                        continue
                    end
                end
                if isnothing(date)
                    @warn "No date found in $file"
                    continue
                end
                push!(posts, (file, title, date))
            end
        end
    end

    # Sort by date
    sort!(posts, by=x -> x[3], rev=true)

    # Make the list. Need to do raw HTML here.
    io = IOBuffer()
    for (file, title, date) in posts
        # Create relative path with no .md
        file = replace(file, r"\.md$" => "")
        @info file

        println(io, "<li>")
        println(io, "<span class=\"date\">$(date)</span>")
        println(io, "<a href=\"/$(file)\">$(title)</a>")
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
