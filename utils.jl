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

@delay function hfun_list_posts(folders)
    posts = []
    for folder in folders
        for file in readdir(folder, join=true)
            if endswith(file, ".md")
                # Get title, date and draft status
                title = pagevar(file, :title)
                date = string_to_date(pagevar(file, :date))
                is_draft = pagevar(file, :draft)

                # Only skip adding to the posts list if it's a draft
                # but still process the file for rendering
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

                # Only add non-draft posts to the listing
                if is_draft !== true
                    push!(posts, (file, title, date))
                end
            end
        end
    end

    # Sort by date
    sort!(posts, by=x -> x[3], rev=true)

    # years = unique(x -> year(x[3]), posts)
    yrs = map(x -> year(x[3]), posts)
    current_year = typemax(Int)
    @info "Starting at $current_year"

    # Make the list. Need to do raw HTML here.
    io = IOBuffer()

    println(
        io,
        """
        <p>
        Here's some of my blog posts. Hope you enjoy them. I write sporadically.
        </p>
        """
    )

    println(io, "<ul>")
    for (file, title, date) in posts
        # Create relative path with no .md
        file = replace(file, r"\.md$" => "")
        # @info file

        file_year = year(date)

        # @info "" file_year current_year file title
        if file_year != current_year
            println(io, "</ul>")
            println(io, "<h2 class=\"blog-list-year\">$(file_year)</h2>")
            println(io, "<ul>")
            current_year = file_year
        end

        println(io, "<li>")
        # Remove the date span, just keep the title
        println(io, "<a class=\"blog-list-title\" href=\"/$(file)\">$(title)</a>")
        println(io, "</li>")
    end
    println(io, "</ul>")

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

"""
    hfun_list_notes(folders)

Lists notes from specified folders, similar to blog posts but with a simpler format.
"""
@delay function hfun_list_notes(folders)
    notes = []
    for folder in folders
        for file in readdir(folder, join=true)
            if endswith(file, ".md")
                # Get title, date and draft status
                title = pagevar(file, :title)
                date = string_to_date(pagevar(file, :date))
                is_draft = pagevar(file, :draft)

                # Try to extract title from first # line if not found
                if isnothing(title)
                    @warn "No title found in $file, trying to use # line"
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

                # Only add non-draft notes to the listing
                if is_draft !== true
                    push!(notes, (file, title, date))
                end
            end
        end
    end

    # Sort by date (most recent first)
    sort!(notes, by=x -> x[3], rev=true)

    # Generate HTML
    io = IOBuffer()

    println(
        io,
        """
        <p>
        Quick notes and thoughts on various topics.
        </p>
        """
    )

    println(io, "<ul>")
    for (file, title, date) in notes
        # Create relative path with no .md
        file = replace(file, r"\.md$" => "")
        
        println(io, "<li>")
        println(io, "<a class=\"blog-list-title\" href=\"/$(file)\">$(title)</a>")
        println(io, "</li>")
    end
    println(io, "</ul>")

    return String(take!(io))
end
