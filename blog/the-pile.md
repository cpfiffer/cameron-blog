+++
title= "Getting the Pile"
date= Date(2023,06,29)
+++

I've been interested in various NLP stuff lately, as one might imagine with all the ChatGPT stuff going on. Something I've become interested in is methods for anlayzing large amounts of text. I've been looking at the [Pile](https://pile.eleuther.ai/) dataset, which is a commonly-used dataset in NLP. I believe ChatGPT has been trained on it, as have many other large [foundation models](https://en.wikipedia.org/wiki/Foundation_models). 

I'm trying to download it to tinker with [discrete normalizing flows](https://arxiv.org/abs/1905.10347) for token prediction. It's a big dataset -- about 825GB uncompressed. Being a hardo, I wrote my only little cloning script to pull in all the new data. It's not very efficient, but it works. I'll probably write a better one later. 

If you want to use this code, make sure to change the `data_dir` variable to wherever you want to store the data.

```julia
using HTTP
using ProgressMeter
import SHA
import Downloads

# Pile root directory
pile_root = "https://the-eye.eu/public/AI/pile/"
data_dir = "/data/the-pile/mirror/"

# Links path
links_path = joinpath(data_dir, "links.txt")

function update_progress(meter, total, now)
    meter.n = total
    if now == total
        # println("Done!")
    else
        update!(meter, now)
    end
end

"""
Extract the links from a url and return them as a vector. Remove any any links that include
".." in the path.
"""
function extract_links(url)
    # Send simple get query to pile root directory
    response = HTTP.get(url)
    body = String(response.body)

    # Extract hrefs from html
    hrefs = eachmatch(r"(?<=href=\")[^\"]+", body)
    links = map(x -> url * x.match, hrefs)
    filter!(x -> basename(dirname(x)) != "..", links)

    # # Write links to file
    # open(links_path, "w") do f
    #     for link in links
    #         println(f, link)
    #     end
    # end

    # Find all the links that are directories
    dirs = filter(x -> endswith(x, "/"), links)

    # Call extract_links on each directory and concatenate the results
    for dir in dirs
        links = vcat(links, extract_links(dir))
    end

    # Remove duplicates
    return unique(links)
end

if !isfile(links_path)
    # Send simple get query to pile root directory
    links = extract_links(pile_root)

    # Write links to file
    open(links_path, "w") do f
        for link in links
            println(f, link)
        end
    end

    # Fink the link that contains SHA
    sha_link = links[findfirst(x -> occursin("SHA", x), links)]

    # Download the SHA file if it doesn't exist
    ddir = joinpath(data_dir, basename(sha_link))
    !isdir(dirname(ddir)) && mkdir(dirname(ddir))
    if !isfile(ddir)
        download(sha_link, ddir)
    end
end

# Read the SHA file
sha = open(ddir) do f
    read(f, String)
end

# Split the SHA file into lines
lines = split(sha, "\n")

# Split each line into SHA and file name
lines = map(x -> split(x, " "), lines)

# Filter out empty lines
lines = filter(x -> length(x) > 0, [filter(x -> length(x) > 0, line) for line in lines])

# Separate into filename and sha
filenames = [joinpath(line[2]) for line in lines]
shas = [line[1] for line in lines]

# Create a dictionary of filenames and shas
sha_dict = Dict(zip(filenames, shas))

# Open links file
links = open(links_path) do f
    readlines(f)
end

# Filter out links ending in /
filter!(x -> !endswith(x, "/"), links)

# For each link, check if it's been downloaded
for link in links
    # Get the filename
    file_relative = replace(link, pile_root => "")

    # Check if the file exists
    file = joinpath(data_dir, file_relative)

    # Determine whether to re-download the file
    download_file = if isfile(file)
        # Check if the file is the correct size
        file_size = filesize(file)

        if file_size == 0 
            true
        else
            sha_local = open(file) do f
                SHA.sha2_256(f)
            end

            if haskey(sha_dict, "./" * file_relative)
                sha_local != sha_dict["./" * file_relative]
            else
                true
            end
        end
    else
        true
    end

    # Download the file if necessary
    if download_file
        # Create the directory if it doesn't exist
        !isdir(dirname(file)) && mkdir(dirname(file))

        # Make the meter
        p = ProgressMeter.Progress(1; desc=file_relative, dt=1)
        update_fun(total, now) = update_progress(p, total, now)

        # Download the file
        println("Downloading $file")
        Downloads.download(link, file, progress=update_fun)
    end
end
```